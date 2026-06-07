<template>
  <div class="hall-container">
    <div class="hall-sidebar">
      <div class="filter-section">
        <h4 class="filter-title">学科分类</h4>
        <div class="filter-items">
          <el-checkbox
            v-for="item in subjectGroups"
            :key="item.key"
            :model-value="activeSubjects.includes(item.key)"
            :disabled="loading"
            @change="(val) => toggleSubject(item.key, val)"
          >
            {{ item.label }}
          </el-checkbox>
        </div>
      </div>

      <div class="filter-section">
        <h4 class="filter-title">竞赛级别</h4>
        <div class="filter-items">
          <el-radio-group v-model="activeLevel" @change="handleLevelChange" :disabled="loading">
            <el-radio v-for="item in levelOptions" :key="item.value" :value="item.value" class="level-radio">
              {{ item.label }}
            </el-radio>
          </el-radio-group>
        </div>
      </div>

      <div class="filter-section">
        <h4 class="filter-title">排序方式</h4>
        <div class="filter-items">
          <el-radio-group v-model="activeSort" @change="handleQuery" :disabled="loading">
            <el-radio v-for="item in sortOptions" :key="item.value" :value="item.value" class="sort-radio">
              {{ item.label }}
            </el-radio>
          </el-radio-group>
        </div>
      </div>
    </div>

    <div class="hall-main">
      <el-form :model="queryParams" ref="queryRef" :inline="true" class="search-bar">
        <el-form-item prop="competitionName">
          <el-input
            v-model="queryParams.competitionName"
            placeholder="搜索竞赛名称"
            clearable
            style="width: 280px"
            @keyup.enter="handleQuery"
          >
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item prop="status">
          <el-select v-model="queryParams.status" placeholder="全部状态" clearable style="width: 130px" @change="handleQuery">
            <el-option v-for="dict in competition_status" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <div class="result-summary" v-if="!loading">
        <span>共 <strong>{{ total }}</strong> 个竞赛</span>
        <span v-if="activeSubjects.length" class="filter-tag">
          学科: {{ activeSubjects.map(k => subjectGroups.find(g => g.key === k)?.label).join('、') }}
        </span>
        <span v-if="activeLevel" class="filter-tag">
          级别: {{ levelOptions.find(l => l.value === activeLevel)?.label }}
        </span>
      </div>

      <div v-loading="loading" class="comp-grid">
        <el-card
          v-for="item in competitionList"
          :key="item.competitionId"
          shadow="never"
          class="comp-card"
          @click="openDetail(item.competitionId)"
        >
          <div class="comp-card-top">
            <dict-tag :options="competition_status" :value="item.status" />
            <span class="comp-view-count">
              <template v-if="item.viewCount > 10000">{{ (item.viewCount / 10000).toFixed(1) }}万</template>
              <template v-else>{{ item.viewCount }}</template>
              浏览
            </span>
          </div>
          <h3 class="comp-name" :title="item.competitionName">{{ item.competitionName }}</h3>
          <p class="comp-desc" :title="stripHtml(item.description)">
            {{ stripHtml(item.description) || '暂无描述' }}
          </p>
          <div class="comp-badges">
            <dict-tag :options="competition_category" :value="item.category" />
            <dict-tag :options="competition_level" :value="item.competitionLevel" />
            <dict-tag :options="competition_type" :value="item.competitionType" />
          </div>
          <div class="comp-meta">
            <span class="comp-organizer" :title="item.organizer">{{ item.organizer || '-' }}</span>
            <span class="comp-deadline">截止 {{ parseTime(item.applyEndTime, '{y}-{m}-{d}') }}</span>
          </div>
          <div class="comp-tags" v-if="parseTags(item.tags).length">
            <el-tag
              v-for="tag in parseTags(item.tags)"
              :key="tag"
              size="small"
              :type="getTagType(tag)"
            >{{ tag }}</el-tag>
          </div>
          <div class="comp-action">
            <span class="comp-action-text">查看详情 &rarr;</span>
          </div>
        </el-card>
      </div>

      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
      />
    </div>

    <el-dialog title="确认报名" v-model="applyOpen" width="480px" append-to-body>
      <el-form :model="applyForm" label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ currentCompetition.competitionName }}</span>
        </el-form-item>
        <el-form-item label="赛制">
          <dict-tag :options="competition_type" :value="currentCompetition.competitionType" />
        </el-form-item>
        <el-form-item label="报名用户">
          <span>{{ userStore.name }}</span>
        </el-form-item>
        <el-form-item label="用户昵称">
          <span>{{ userStore.nickName || userStore.name }}</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="applyLoading" @click="submitApply">确定提交</el-button>
        <el-button @click="applyOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="创建队伍" v-model="createTeamOpen" width="480px" append-to-body>
      <el-form :model="teamForm" label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ currentCompetition.competitionName }}</span>
        </el-form-item>
        <el-form-item label="赛制">
          <dict-tag :options="competition_type" :value="currentCompetition.competitionType" />
        </el-form-item>
        <el-form-item label="队伍名称" prop="teamName" :rules="[{ required: true, message: '请输入队伍名称' }]">
          <el-input v-model="teamForm.teamName" placeholder="请输入队伍名称" maxlength="20" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="teamLoading" @click="submitCreateTeam">创建队伍</el-button>
        <el-button @click="createTeamOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="加入队伍" v-model="joinTeamOpen" width="480px" append-to-body>
      <el-form :model="joinForm" label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ currentCompetition.competitionName }}</span>
        </el-form-item>
        <el-form-item label="邀请码" prop="inviteCode" :rules="[{ required: true, message: '请输入邀请码' }]">
          <el-input v-model="joinForm.inviteCode" placeholder="请输入队长分享的6位邀请码" maxlength="6" style="text-transform: uppercase" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="teamLoading" @click="submitJoinTeam">加入队伍</el-button>
        <el-button @click="joinTeamOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="我的队伍" v-model="viewTeamOpen" width="600px" append-to-body>
      <div v-if="myTeamInfo">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="队伍名称" :span="2">{{ myTeamInfo.teamName }}</el-descriptions-item>
          <el-descriptions-item label="队长">{{ myTeamInfo.leaderName }}</el-descriptions-item>
          <el-descriptions-item label="你的角色">
            <el-tag v-if="myTeamInfo.userRole === 'leader'" type="danger" size="small">队长</el-tag>
            <el-tag v-else type="success" size="small">队员</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="邀请码">
            <el-tag type="warning">{{ myTeamInfo.inviteCode }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="队伍人数">{{ myTeamInfo.currentMembers }} / {{ myTeamInfo.maxMembers }}</el-descriptions-item>
          <el-descriptions-item label="队伍状态">
            <dict-tag :options="team_status" :value="myTeamInfo.status" />
          </el-descriptions-item>
          <el-descriptions-item v-if="myTeamInfo.userRole === 'leader'" label="公开招募" :span="2">
            <el-switch v-model="myTeamInfo.isPublic" active-value="1" inactive-value="0" @change="togglePublic" />
            <span style="margin-left: 8px; font-size: 12px; color: #909399">开启后在组队广场展示</span>
          </el-descriptions-item>
          <el-descriptions-item v-if="myTeamInfo.userRole === 'leader'" label="所需技能" :span="2">
            <el-button link type="primary" size="small" @click="skillDialogOpen = true">
              {{ teamSkillsInput || '点击选择所需技能' }}
            </el-button>
          </el-descriptions-item>
        </el-descriptions>

        <el-divider v-if="myTeamInfo.userRole === 'leader'" content-position="left">指导教师</el-divider>
        <div v-if="myTeamInfo.userRole === 'leader'" class="teacher-section">
          <div v-if="teamInvitations.length > 0" style="margin-bottom: 12px">
            <el-tag v-for="inv in teamInvitations" :key="inv.invitationId" size="small" :type="invitationStatusType(inv.status)" style="margin-right: 8px">
              {{ inv.teacherName || '教师' + inv.teacherId }} -
              {{ inv.status === '0' ? '待确认' : inv.status === '1' ? '已接受' : inv.status === '2' ? '已拒绝' : '已撤销' }}
              <el-button v-if="inv.status === '0'" link size="small" @click="handleCancelInvitation(inv)" style="margin-left: 4px">撤销</el-button>
            </el-tag>
          </div>
          <div style="display: flex; gap: 8px">
            <el-input v-model="inviteForm.teacherId" placeholder="输入教师用户名或ID" size="small" style="width: 220px" />
            <el-button type="primary" size="small" :loading="inviteLoading" @click="handleInviteTeacher">发送邀请</el-button>
          </div>
        </div>

        <el-divider content-position="left">队伍成员</el-divider>
        <el-table :data="teamMembers" size="small">
          <el-table-column label="姓名" prop="userName" />
          <el-table-column label="昵称" prop="nickName" />
          <el-table-column label="加入时间" width="160">
            <template #default="scope">{{ parseTime(scope.row.joinTime) }}</template>
          </el-table-column>
          <el-table-column label="角色" min-width="120">
            <template #default="scope">
              <el-tag v-if="scope.row.userId === myTeamInfo.leaderId" type="danger" size="small">队长</el-tag>
              <template v-else>
                <el-tag type="info" size="small">队员</el-tag>
                <el-button
                  v-if="myTeamInfo.userRole === 'leader'"
                  link
                  type="warning"
                  size="small"
                  style="margin-left: 8px"
                  @click="handleTransferLeader(scope.row)"
                >移交队长</el-button>
              </template>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <template #footer>
        <el-button @click="viewTeamOpen = false">关 闭</el-button>
      </template>
    </el-dialog>

    <SkillSelector v-model="skillDialogOpen" :current-skills="teamSkillsInput" @save="onSkillSave" />
  </div>
</template>

<script setup>
import { Search } from '@element-plus/icons-vue'
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()
const {
  competition_status,
  competition_category,
  competition_type,
  competition_level,
  team_status
} = useDict('competition_status', 'competition_category', 'competition_type', 'competition_level', 'team_status')

const competitionList = ref([])
const loading = ref(true)
const total = ref(0)
const detailOpen = ref(false)
const applyOpen = ref(false)
const applyLoading = ref(false)
const currentCompetition = ref({})

const createTeamOpen = ref(false)
const joinTeamOpen = ref(false)
const viewTeamOpen = ref(false)
const teamLoading = ref(false)
const myTeamInfo = ref(null)
const teamMembers = ref([])

const teamForm = ref({ teamName: '' })
const joinForm = ref({ inviteCode: '' })
const teamSkillsInput = ref('')
const skillDialogOpen = ref(false)

const inviteLoading = ref(false)
const teacherList = ref([])
const teamInvitations = ref([])
const inviteForm = ref({ teacherId: null })

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    competitionName: undefined,
    status: undefined
  }
})
const { queryParams } = toRefs(data)

import { listCompetition, getCompetition, applyCompetition } from '@/api/competition/hall'
import { createTeam, joinTeam, getMyTeam, getTeamMembers, transferLeader, toggleTeamPublic, updateTeamSkills } from '@/api/competition/team'
import { inviteTeacher, listTeamInvitations, cancelInvitation } from '@/api/competition/invitation'
import auth from '@/plugins/auth'
import SkillSelector from './SkillSelector.vue'

const isTeacher = computed(() => auth.hasRole('teacher'))

const isCompetitionFull = computed(() => {
  const c = currentCompetition.value
  return c.competitionType === '1'
    && c.maxParticipants > 0
    && c.currentParticipants >= c.maxParticipants
})

const subjectGroups = [
  { key: 'engineering', label: '工科', codes: ['03', '05'] },
  { key: 'liberal',    label: '文体', codes: ['04'] },
  { key: 'science',    label: '理科', codes: ['06'] },
  { key: 'business',   label: '商科', codes: ['02'] },
  { key: 'comprehensive', label: '综合', codes: ['01'] }
]

const levelOptions = [
  { value: '',     label: '不限' },
  { value: '1',    label: '校级' },
  { value: '2',    label: '市级' },
  { value: '3',    label: '省级' },
  { value: '4',    label: '国家级' },
  { value: '5',    label: '国际级' },
  { value: '99',   label: '其他' }
]

const sortOptions = [
  { value: '',      label: '默认' },
  { value: 'apply', label: '报名时间' },
  { value: 'start', label: '开赛时间' },
  { value: 'update',label: '最近更新' },
  { value: 'view',  label: '最多浏览' }
]

const activeSubjects = ref([])
const activeLevel = ref('')
const activeSort = ref('')

function toggleSubject(key, checked) {
  if (checked) {
    activeSubjects.value.push(key)
  } else {
    activeSubjects.value = activeSubjects.value.filter(k => k !== key)
  }
  handleQuery()
}

function handleLevelChange() {
  handleQuery()
}

function getList() {
  loading.value = true
  const params = {
    pageNum: queryParams.value.pageNum,
    pageSize: queryParams.value.pageSize,
    competitionName: queryParams.value.competitionName,
    status: queryParams.value.status,
    sortBy: activeSort.value || undefined,
    competitionLevel: activeLevel.value || undefined
  }
  if (activeSubjects.value.length) {
    params.categories = activeSubjects.value
      .flatMap(k => subjectGroups.find(g => g.key === k)?.codes || [])
      .join(',')
  }
  listCompetition(params).then(response => {
    competitionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  activeSubjects.value = []
  activeLevel.value = ''
  activeSort.value = ''
  handleQuery()
}

function handleDetail(row) {
  getCompetition(row.competitionId).then(response => {
    currentCompetition.value = response.data
    detailOpen.value = true
    if (currentCompetition.value.competitionType === '2') {
      checkMyTeam()
    } else {
      myTeamInfo.value = null
    }
  })
}

function openDetail(id) {
  const resolved = useRouter().resolve({ path: '/match/hall/' + id })
  window.open(resolved.href, '_blank')
}

function checkMyTeam() {
  myTeamInfo.value = null
  getMyTeam(currentCompetition.value.competitionId).then(response => {
    if (response.data) {
      myTeamInfo.value = response.data
    }
  }).catch(() => {})
}

function handleCreateTeam() {
  detailOpen.value = false
  teamForm.value.teamName = ''
  nextTick(() => {
    createTeamOpen.value = true
  })
}

function handleJoinTeam() {
  detailOpen.value = false
  joinForm.value.inviteCode = ''
  nextTick(() => {
    joinTeamOpen.value = true
  })
}

function handleViewTeam() {
  detailOpen.value = false
  nextTick(() => {
    viewTeamOpen.value = true
    loadTeamMembers()
    loadTeamInvitations()
  })
}

function loadTeamMembers() {
  if (!myTeamInfo.value) return
  getTeamMembers(myTeamInfo.value.teamId).then(response => {
    teamMembers.value = response.data || []
  })
  teamSkillsInput.value = myTeamInfo.value.neededSkills || ''
}

function togglePublic(val) {
  toggleTeamPublic(myTeamInfo.value.teamId, val === '1').then(() => {
    proxy.$modal.msgSuccess(val === '1' ? '已公开招募' : '已关闭公开招募')
  })
}

function saveSkills() {
  updateTeamSkills(myTeamInfo.value.teamId, teamSkillsInput.value).then(() => {
    proxy.$modal.msgSuccess('技能已更新')
    checkMyTeam()
  })
}

function onSkillSave(skills) {
  teamSkillsInput.value = skills
  saveSkills()
}

function handleTransferLeader(member) {
  proxy.$modal.confirm('确定将队长移交给【' + member.userName + '】吗？移交后你将失去队长权限。', '提示', {
    confirmButtonText: '确定移交',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    return transferLeader(myTeamInfo.value.teamId, member.userId)
  }).then(() => {
    proxy.$modal.msgSuccess('队长已移交')
    checkMyTeam()
    loadTeamMembers()
  })
}

function submitCreateTeam() {
  if (!teamForm.value.teamName.trim()) {
    proxy.$modal.msgError('请输入队伍名称')
    return
  }
  teamLoading.value = true
  createTeam(currentCompetition.value.competitionId, teamForm.value.teamName.trim()).then(response => {
    proxy.$modal.msgSuccess('队伍创建成功！邀请码：' + response.data.inviteCode)
    teamLoading.value = false
    createTeamOpen.value = false
    myTeamInfo.value = response.data
    nextTick(() => {
      viewTeamOpen.value = true
      loadTeamMembers()
    })
  }).catch(() => {
    teamLoading.value = false
  })
}

function submitJoinTeam() {
  if (!joinForm.value.inviteCode.trim()) {
    proxy.$modal.msgError('请输入邀请码')
    return
  }
  teamLoading.value = true
  joinTeam(currentCompetition.value.competitionId, joinForm.value.inviteCode.trim()).then(response => {
    proxy.$modal.msgSuccess('成功加入队伍：' + response.data.teamName)
    teamLoading.value = false
    joinTeamOpen.value = false
    myTeamInfo.value = response.data
    nextTick(() => {
      viewTeamOpen.value = true
      loadTeamMembers()
    })
  }).catch(() => {
    teamLoading.value = false
  })
}

function handleApply() {
  detailOpen.value = false
  nextTick(() => {
    applyOpen.value = true
  })
}

function submitApply() {
  applyLoading.value = true
  applyCompetition(currentCompetition.value.competitionId).then(() => {
    proxy.$modal.msgSuccess('报名成功')
    applyLoading.value = false
    applyOpen.value = false
    getList()
  }).catch(() => {
    applyLoading.value = false
  })
}

function parseTags(tags) {
  if (!tags) return []
  try {
    return JSON.parse(tags)
  } catch (e) {
    return []
  }
}

function stripHtml(html) {
  if (!html) return ''
  const text = html.replace(/<[^>]+>/g, '').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&')
  return text.length > 80 ? text.substring(0, 80) + '...' : text
}

const tagTypeMap = {
  'A类赛事': 'danger', 'B类赛事': 'warning', '国家级': 'danger', '国际级': 'danger',
  '保研加分': 'success', '综测加分': 'success', '综合测评加分': 'success', '立项支持': 'success',
  '双一流高校覆盖': 'warning', '挑战杯热身': 'warning', '国赛热身': 'warning',
  '数学建模': 'primary', '人工智能': 'primary', '客观题答题': 'info',
  '国家一级社团': 'info', '互联网+': 'info'
}

function getTagType(tag) {
  for (const [key, type] of Object.entries(tagTypeMap)) {
    if (tag.includes(key)) return type
  }
  return 'info'
}

function loadTeamInvitations() {
  if (!myTeamInfo.value || !myTeamInfo.value.teamId) return
  listTeamInvitations(myTeamInfo.value.teamId).then(res => {
    teamInvitations.value = res.data || []
  })
}

function handleInviteTeacher() {
  const teacherId = inviteForm.value.teacherId
  if (!teacherId) {
    proxy.$modal.msgError('请输入教师用户名或ID')
    return
  }
  if (!myTeamInfo.value || !myTeamInfo.value.teamId) return
  inviteLoading.value = true
  inviteTeacher(myTeamInfo.value.teamId, {
    teacherId: isNaN(teacherId) ? null : parseInt(teacherId),
    teacherName: isNaN(teacherId) ? teacherId : '',
    competitionId: currentCompetition.value.competitionId,
    competitionName: currentCompetition.value.competitionName,
    teamName: myTeamInfo.value.teamName
  }).then(() => {
    proxy.$modal.msgSuccess('邀请已发送')
    inviteLoading.value = false
    inviteForm.value.teacherId = ''
    loadTeamInvitations()
  }).catch(() => {
    inviteLoading.value = false
  })
}

function handleCancelInvitation(inv) {
  proxy.$modal.confirm('确认撤销该邀请？').then(() => {
    return cancelInvitation(inv.invitationId)
  }).then(() => {
    proxy.$modal.msgSuccess('已撤销')
    loadTeamInvitations()
  })
}

function invitationStatusType(status) {
  if (status === '0') return 'warning'
  if (status === '1') return 'success'
  if (status === '2') return 'danger'
  return 'info'
}

getList()
</script>

<style scoped>
.hall-container {
  --md3-primary: #1a73e8;
  --md3-title: #202124;
  --md3-body: #5f6368;
  --md3-border: #e0e0e0;
  --md3-surface: #ffffff;
  --md3-bg: #f8f9fa;
  --md3-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
  --md3-shadow-hover: 0 1px 3px 0 rgba(60,64,67,0.3), 0 4px 8px 3px rgba(60,64,67,0.15);
  --md3-radius-lg: 12px;
  --md3-radius-pill: 8px;
  display: flex;
  gap: 16px;
}

.hall-sidebar {
  width: 200px;
  flex-shrink: 0;
  background: #fff;
  border-radius: 4px;
  padding: 16px 12px;
  height: fit-content;
  position: sticky;
  top: 80px;
}

.hall-main {
  flex: 1;
  min-width: 0;
}

.filter-section {
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #ebeef5;
}
.filter-section:last-child {
  border-bottom: none;
  margin-bottom: 0;
}

.filter-title {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 8px 0;
}

.filter-items {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.filter-items :deep(.el-checkbox) {
  height: 28px;
  margin-right: 0;
}

.level-radio, .sort-radio {
  display: block;
  height: 28px;
  line-height: 28px;
  margin-right: 0;
}

.search-bar {
  margin-bottom: 12px;
  padding: 0;
}
.search-bar :deep(.el-form-item) {
  margin-bottom: 8px;
  margin-right: 8px;
}
.search-bar :deep(.el-input__wrapper),
.search-bar :deep(.el-button) {
  border-radius: 8px;
}

.result-summary {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 10px;
  font-size: 13px;
  color: #606266;
}
.result-summary strong {
  color: #409eff;
}
.filter-tag {
  display: inline-block;
  padding: 2px 8px;
  background: #ecf5ff;
  color: #409eff;
  border-radius: 3px;
  font-size: 12px;
}

.comp-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 20px;
}

.comp-card {
  background: var(--md3-surface);
  border-radius: 16px;
  box-shadow: var(--md3-shadow);
  border: none;
  cursor: pointer;
  transition: box-shadow 0.2s ease;
}

.comp-card:hover {
  box-shadow: var(--md3-shadow-hover);
}

.comp-card :deep(.el-card__body) {
  padding: 20px;
}

.comp-card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.comp-view-count {
  font-size: 12px;
  color: var(--md3-body);
}

.comp-name {
  font-size: 16px;
  font-weight: 600;
  color: var(--md3-title);
  margin: 0 0 8px 0;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.comp-desc {
  font-size: 13px;
  color: var(--md3-body);
  line-height: 1.5;
  margin: 0 0 12px 0;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.comp-badges {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
  margin-bottom: 12px;
}

.comp-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: var(--md3-body);
  margin-bottom: 12px;
}

.comp-organizer {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 60%;
}

.comp-deadline {
  flex-shrink: 0;
}

.comp-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  margin-bottom: 12px;
}

.comp-action {
  padding-top: 12px;
  border-top: 1px solid var(--md3-border);
}

.comp-action-text {
  font-size: 13px;
  color: var(--md3-primary);
  font-weight: 500;
}

.teacher-section {
  margin-bottom: 8px;
}

.rich-content {
  max-height: 400px;
  overflow-y: auto;
  line-height: 1.8;
}
.rich-content :deep(p) {
  margin: 4px 0;
}
.rich-content :deep(strong) {
  color: #303133;
}

.hall-container :deep(.el-tag) {
  border: none;
  border-radius: 14px;
}

@media (max-width: 900px) {
  .hall-sidebar {
    display: none;
  }
}
</style>
