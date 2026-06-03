<template>
  <div class="app-container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px">
      <div>
        <el-tag
          v-for="skill in allSkills"
          :key="skill"
          :type="filterSkills.includes(skill) ? 'success' : 'info'"
          style="margin-right: 6px; cursor: pointer"
          size="small"
          @click="toggleSkill(skill)"
        >{{ skill }}</el-tag>
      </div>
      <div>
        <el-button :type="userMarketVisible ? 'danger' : 'success'" size="small" @click="toggleMyMarket">
          {{ userMarketVisible ? '隐藏我的信息' : '公开我的信息' }}
        </el-button>
        <el-button size="small" @click="showInvitations">我的组队邀请</el-button>
        <el-button size="small" @click="goTeamSquare">去组队广场</el-button>
      </div>
    </div>

    <el-row :gutter="16">
      <el-col v-for="user in userList" :key="user.userId" :span="6" style="margin-bottom: 16px">
        <el-card shadow="hover">
          <div style="text-align: center; margin-bottom: 8px">
            <el-avatar :size="50" :src="user.avatar" />
            <div style="font-weight: 600; margin-top: 4px">{{ user.nickName || user.userName }}</div>
            <div style="color: #909399; font-size: 12px">{{ user.grade || '未知年级' }}</div>
          </div>
          <div style="text-align: center">
            <el-tag v-for="s in (user.skillTags || '').split(',').filter(Boolean)" :key="s" size="small" type="primary" style="margin: 2px">{{ s.trim() }}</el-tag>
            <span v-if="!user.skillTags" style="color: #c0c4cc; font-size: 12px">未填写技能</span>
          </div>
          <div style="text-align: center; margin-top: 10px">
            <el-button type="success" size="small" @click="handleInvite(user)">邀请加入队伍</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

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
