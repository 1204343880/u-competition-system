<template>
  <div class="market-container">
    <div class="market-toolbar">
      <div class="market-skills">
        <el-tag
          v-for="skill in allSkills"
          :key="skill"
          :type="filterSkills.includes(skill) ? 'success' : 'info'"
          class="skill-chip"
          @click="toggleSkill(skill)"
        >{{ skill }}</el-tag>
      </div>
      <div class="market-actions">
        <el-button :type="userMarketVisible ? 'danger' : 'success'" size="small" @click="toggleMyMarket">
          {{ userMarketVisible ? '隐藏我的信息' : '公开我的信息' }}
        </el-button>
        <el-button size="small" @click="showInvitations">我的组队邀请</el-button>
        <el-button size="small" @click="goTeamSquare">去组队广场</el-button>
      </div>
    </div>

    <div class="user-grid">
      <el-card
        v-for="user in userList"
        :key="user.userId"
        shadow="never"
        class="user-card"
      >
        <div class="user-avatar-area">
          <el-avatar :size="56" :src="user.avatar" />
          <div class="user-name">{{ user.nickName || user.userName }}</div>
          <div class="user-grade">{{ user.grade || '未知年级' }}</div>
        </div>
        <div class="user-skills">
          <el-tag
            v-for="s in (user.skillTags || '').split(',').filter(Boolean)"
            :key="s"
            size="small"
            type="primary"
          >{{ s.trim() }}</el-tag>
          <span v-if="!user.skillTags" class="no-skills">未填写技能</span>
        </div>
        <div class="user-actions">
          <el-button type="success" size="small" @click="handleInvite(user)">邀请加入队伍</el-button>
        </div>
      </el-card>
    </div>

    <el-empty v-if="!userList.length && !loading" description="暂无学生在人才市场展示" />

    <el-dialog title="邀请加入队伍" v-model="inviteDialogOpen" width="480px" append-to-body>
      <el-form label-width="80px" v-if="inviteTargetUser">
        <el-form-item label="目标用户">
          <span style="font-weight: 600">{{ inviteTargetUser.nickName || inviteTargetUser.userName }}</span>
        </el-form-item>
        <el-form-item label="选择队伍" prop="teamId" :rules="[{ required: true, message: '请选择队伍' }]">
          <el-select v-model="inviteForm.teamId" placeholder="请选择你作为队长的队伍" style="width: 100%">
            <el-option
              v-for="team in myLeaderTeams"
              :key="team.teamId"
              :label="team.teamName + ' (' + team.competitionName + ')'"
              :value="team.teamId"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <div v-else style="text-align: center; color: #909399; padding: 20px">
        <p v-if="myLeaderTeams.length === 0">你还没有担任队长的队伍，请先创建队伍</p>
      </div>
      <template #footer>
        <el-button type="primary" :disabled="!inviteForm.teamId" :loading="inviteLoading" @click="submitInvite">发送邀请</el-button>
        <el-button @click="inviteDialogOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="我的组队邀请" v-model="invitationsDialogOpen" width="650px" append-to-body>
      <el-table :data="myInvitations" size="small" v-loading="invitationsLoading">
        <el-table-column label="队伍" prop="teamName" />
        <el-table-column label="竞赛" prop="competitionName" />
        <el-table-column label="邀请人" prop="inviterName" />
        <el-table-column label="状态" width="100">
          <template #default="scope">
            <el-tag v-if="scope.row.status === '0'" type="warning" size="small">待处理</el-tag>
            <el-tag v-else-if="scope.row.status === '1'" type="success" size="small">已同意</el-tag>
            <el-tag v-else-if="scope.row.status === '2'" type="danger" size="small">已拒绝</el-tag>
            <el-tag v-else type="info" size="small">已撤销</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="时间" prop="createTime" width="160" />
        <el-table-column label="操作" width="140" v-if="hasPendingInvitation">
          <template #default="scope">
            <template v-if="scope.row.status === '0'">
              <el-button link type="primary" size="small" @click="handleAccept(scope.row)">同意</el-button>
              <el-button link type="danger" size="small" @click="handleReject(scope.row)">拒绝</el-button>
            </template>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!myInvitations.length && !invitationsLoading" description="暂无组队邀请" />
      <template #footer>
        <el-button @click="invitationsDialogOpen = false">关 闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const userList = ref([])
const loading = ref(false)
const filterSkills = ref([])
const allSkills = ref([])
const userMarketVisible = ref(false)

const inviteDialogOpen = ref(false)
const inviteTargetUser = ref(null)
const inviteForm = ref({ teamId: null })
const inviteLoading = ref(false)
const myLeaderTeams = ref([])

const invitationsDialogOpen = ref(false)
const myInvitations = ref([])
const invitationsLoading = ref(false)

import { getMarketList, toggleMarket, getMyTeams, inviteFromMarket, getMyInvitations, acceptInvitation, rejectInvitation } from '@/api/competition/team'
import useUserStore from '@/store/modules/user'

const hasPendingInvitation = computed(() => myInvitations.value.some(i => i.status === '0'))

function getList() {
  loading.value = true
  const skills = filterSkills.value.length ? filterSkills.value.join(',') : undefined
  getMarketList(skills).then(response => {
    userList.value = response.data || []
    const skillSet = new Set()
    userList.value.forEach(u => {
      (u.skillTags || '').split(',').filter(Boolean).forEach(s => skillSet.add(s.trim()))
    })
    allSkills.value = Array.from(skillSet)
    userMarketVisible.value = userStore.showInMarket === '1'
    loading.value = false
  })
}

function toggleSkill(skill) {
  const idx = filterSkills.value.indexOf(skill)
  if (idx > -1) {
    filterSkills.value.splice(idx, 1)
  } else {
    filterSkills.value.push(skill)
  }
  getList()
}

function toggleMyMarket() {
  toggleMarket().then(response => {
    proxy.$modal.msgSuccess(response.msg)
    userMarketVisible.value = !userMarketVisible.value
    getList()
  })
}

function goTeamSquare() {
  proxy.$router.push('/match/team-square')
}

function handleInvite(user) {
  inviteTargetUser.value = user
  inviteForm.value.teamId = null
  getMyTeams().then(response => {
    const teams = response.data || []
    myLeaderTeams.value = teams.filter(t => t.userRole === 'leader' && t.status === '0')
    inviteDialogOpen.value = true
  })
}

function submitInvite() {
  if (!inviteForm.value.teamId || !inviteTargetUser.value) return
  inviteLoading.value = true
  inviteFromMarket(inviteTargetUser.value.userId, inviteForm.value.teamId).then(() => {
    proxy.$modal.msgSuccess('邀请已发送')
    inviteLoading.value = false
    inviteDialogOpen.value = false
  }).catch(() => {
    inviteLoading.value = false
  })
}

function showInvitations() {
  invitationsDialogOpen.value = true
  loadInvitations()
}

function loadInvitations() {
  invitationsLoading.value = true
  getMyInvitations().then(response => {
    myInvitations.value = response.data || []
    invitationsLoading.value = false
  }).catch(() => {
    invitationsLoading.value = false
  })
}

function handleAccept(record) {
  proxy.$modal.confirm('确定加入队伍【' + record.teamName + '】？').then(() => {
    return acceptInvitation(record.id)
  }).then(() => {
    proxy.$modal.msgSuccess('已加入队伍')
    loadInvitations()
  })
}

function handleReject(record) {
  proxy.$modal.confirm('确定拒绝该邀请？').then(() => {
    return rejectInvitation(record.id)
  }).then(() => {
    proxy.$modal.msgSuccess('已拒绝邀请')
    loadInvitations()
  })
}

getList()
</script>

<style scoped>
.market-container {
  --md3-primary: #1a73e8;
  --md3-title: #202124;
  --md3-body: #5f6368;
  --md3-border: var(--student-line, rgba(31,35,41,.07));
  --md3-surface: var(--student-surface, #fff);
  --md3-bg: var(--student-bg, #f7f8fa);
  --md3-shadow: var(--student-shadow, 0 1px 2px rgba(41,45,52,.04));
  --md3-shadow-hover: var(--student-shadow-hover, 0 10px 26px rgba(38,43,51,.085));
  --md3-radius-lg: 12px;
  --md3-radius-pill: 8px;
}

.market-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
  gap: 16px;
  flex-wrap: wrap;
}

.market-skills {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  flex: 1;
}

.skill-chip {
  cursor: pointer;
  border: none;
  border-radius: 14px;
}

.market-actions {
  display: flex;
  gap: 8px;
  flex-shrink: 0;
}

.user-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 20px;
}

.user-card {
  background: var(--md3-surface);
  border-radius: 16px;
  box-shadow: var(--md3-shadow);
  border: none;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.user-card:hover {
  box-shadow: var(--md3-shadow-hover);
  transform: translateY(-2px);
}

.user-card :deep(.el-card__body) {
  padding: 24px 20px 20px;
}

.user-avatar-area {
  text-align: center;
  margin-bottom: 12px;
}

.user-name {
  font-weight: 600;
  font-size: 15px;
  color: var(--md3-title);
  margin-top: 8px;
}

.user-grade {
  font-size: 12px;
  color: var(--md3-body);
  margin-top: 2px;
}

.user-skills {
  text-align: center;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 4px;
  margin-bottom: 14px;
  min-height: 28px;
}

.no-skills {
  font-size: 12px;
  color: #c0c4cc;
}

.user-actions {
  text-align: center;
  padding-top: 12px;
  border-top: 1px solid var(--md3-border);
}

.market-container :deep(.el-tag) {
  border: none;
  border-radius: 14px;
}
</style>
