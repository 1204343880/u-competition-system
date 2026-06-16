<template>
  <div class="detail-page">
    <div class="detail-topbar">
      <el-button text @click="goBack">
        <el-icon><ArrowLeft /></el-icon>
        返回竞赛列表
      </el-button>
      <span class="detail-title">{{ detail.competitionName }}</span>
      <span class="detail-spacer"></span>
    </div>

    <div class="detail-content" v-loading="loading">
      <div class="hero-card">
        <div class="badges-row">
          <dict-tag :options="competition_category" :value="detail.category" />
          <dict-tag :options="competition_level" :value="detail.competitionLevel" />
          <dict-tag :options="competition_type" :value="detail.competitionType" />
          <dict-tag :options="competition_status" :value="detail.status" />
        </div>

        <h1 class="hero-title">{{ detail.competitionName }}</h1>

        <div class="meta-row">
          <span><el-icon><UserFilled /></el-icon> {{ detail.organizer }}</span>
          <span v-if="detail.host"><el-icon><OfficeBuilding /></el-icon> {{ detail.host }}</span>
          <span><el-icon><View /></el-icon> {{ detail.viewCount }} 次浏览</span>
          <span><el-icon><Avatar /></el-icon> {{ detail.currentParticipants || 0 }} / {{ detail.maxParticipants || '不限' }} 人已报名</span>
        </div>

        <div class="tags-row" v-if="parsedTags.length">
          <el-tag v-for="tag in parsedTags" :key="tag" size="small" type="info">{{ tag }}</el-tag>
        </div>

        <div class="action-row">
          <template v-if="detail.status === '0'">
            <template v-if="detail.competitionType === '1'">
              <el-button type="primary" @click="handleApply" :disabled="isFull">我要报名</el-button>
              <span v-if="isFull" class="full-tip">名额已满</span>
            </template>
            <template v-else-if="detail.competitionType === '2'">
              <el-button v-if="!myTeamInfo" type="primary" @click="handleCreateTeam">创建队伍</el-button>
              <el-button v-if="!myTeamInfo" type="success" @click="handleJoinTeam">加入队伍</el-button>
              <el-button v-if="myTeamInfo" type="primary" @click="handleViewTeam">查看队伍</el-button>
            </template>
          </template>
          <template v-else-if="detail.competitionType === '2' && detail.status !== '0'">
            <span class="deadline-tip">报名已截止</span>
          </template>
        </div>
      </div>

      <div class="timeline-card">
        <h3 class="card-title">竞赛日程</h3>
        <div class="timeline-track">
          <div class="timeline-node" v-for="(node, idx) in timelineNodes" :key="idx">
            <div class="timeline-dot" :class="{ active: node.active }"></div>
            <div class="timeline-line" v-if="idx < timelineNodes.length - 1" :class="{ active: node.active && timelineNodes[idx + 1].active }"></div>
            <div class="timeline-label">{{ node.label }}</div>
            <div class="timeline-date">{{ node.date }}</div>
          </div>
        </div>
      </div>

      <div class="detail-card">
        <h3 class="card-title">竞赛详情</h3>
        <div class="rich-body" v-html="detail.description || '暂无详情'"></div>
      </div>
    </div>

    <el-dialog title="确认报名" v-model="applyOpen" width="480px" append-to-body>
      <el-form label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ detail.competitionName }}</span>
        </el-form-item>
        <el-form-item label="赛制">
          <dict-tag :options="competition_type" :value="detail.competitionType" />
        </el-form-item>
        <el-form-item label="报名用户">
          <span>{{ userStore.name }}</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="applyLoading" @click="submitApply">确定提交</el-button>
        <el-button @click="applyOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="创建队伍" v-model="createTeamOpen" width="480px" append-to-body>
      <el-form label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ detail.competitionName }}</span>
        </el-form-item>
        <el-form-item label="队伍名称" required>
          <el-input v-model="teamForm.teamName" placeholder="请输入队伍名称" maxlength="20" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="teamLoading" @click="submitCreateTeam">创建队伍</el-button>
        <el-button @click="createTeamOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <el-dialog title="加入队伍" v-model="joinTeamOpen" width="480px" append-to-body>
      <el-form label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ detail.competitionName }}</span>
        </el-form-item>
        <el-form-item label="邀请码" required>
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
        </el-descriptions>
      </div>
      <template #footer>
        <el-button @click="viewTeamOpen = false">关 闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ArrowLeft, UserFilled, OfficeBuilding, View, Avatar } from '@element-plus/icons-vue'
import { useRouter, useRoute } from 'vue-router'
import useUserStore from '@/store/modules/user'
import { getCompetition, applyCompetition } from '@/api/competition/hall'
import { createTeam, joinTeam, getMyTeam } from '@/api/competition/team'

const { proxy } = getCurrentInstance()
const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const {
  competition_status,
  competition_category,
  competition_type,
  competition_level,
  team_status
} = useDict('competition_status', 'competition_category', 'competition_type', 'competition_level', 'team_status')

const loading = ref(true)
const detail = ref({})
const myTeamInfo = ref(null)

const applyOpen = ref(false)
const applyLoading = ref(false)

const createTeamOpen = ref(false)
const joinTeamOpen = ref(false)
const viewTeamOpen = ref(false)
const teamLoading = ref(false)

const teamForm = ref({ teamName: '' })
const joinForm = ref({ inviteCode: '' })

const isFull = computed(() => {
  return detail.value.competitionType === '1'
    && detail.value.maxParticipants > 0
    && (detail.value.currentParticipants || 0) >= detail.value.maxParticipants
})

const parsedTags = computed(() => {
  if (!detail.value.tags) return []
  try { return JSON.parse(detail.value.tags) } catch (e) { return [] }
})

const timelineNodes = computed(() => {
  const d = detail.value
  const fmt = (val) => val ? parseTime(val, '{y}-{m}-{d} {h}:{i}') : '待定'
  const now = Date.now()
  const nodes = [
    { label: '报名开始', date: fmt(d.applyStartTime), active: now >= new Date(d.applyStartTime).getTime() },
    { label: '报名截止', date: fmt(d.applyEndTime), active: now >= new Date(d.applyEndTime).getTime() },
    { label: '比赛开始', date: fmt(d.startTime), active: now >= new Date(d.startTime).getTime() },
    { label: '比赛结束', date: fmt(d.endTime), active: now >= new Date(d.endTime).getTime() }
  ]
  return nodes
})

function goBack() {
  router.push('/match/hall')
}

function loadDetail() {
  loading.value = true
  getCompetition(route.params.competitionId).then(response => {
    detail.value = response.data
    loading.value = false
    if (detail.value.competitionType === '2') {
      checkMyTeam()
    }
  }).catch(() => {
    loading.value = false
  })
}

function checkMyTeam() {
  getMyTeam(detail.value.competitionId).then(response => {
    if (response.data) {
      myTeamInfo.value = response.data
    }
  }).catch(() => {})
}

function handleApply() { applyOpen.value = true }
function handleCreateTeam() { teamForm.value.teamName = ''; createTeamOpen.value = true }
function handleJoinTeam() { joinForm.value.inviteCode = ''; joinTeamOpen.value = true }
function handleViewTeam() { viewTeamOpen.value = true }

function submitApply() {
  applyLoading.value = true
  applyCompetition(detail.value.competitionId).then(() => {
    proxy.$modal.msgSuccess('报名成功')
    applyLoading.value = false
    applyOpen.value = false
    loadDetail()
  }).catch(() => { applyLoading.value = false })
}

function submitCreateTeam() {
  if (!teamForm.value.teamName.trim()) {
    proxy.$modal.msgError('请输入队伍名称')
    return
  }
  teamLoading.value = true
  createTeam(detail.value.competitionId, teamForm.value.teamName.trim()).then(response => {
    proxy.$modal.msgSuccess('队伍创建成功！邀请码：' + response.data.inviteCode)
    teamLoading.value = false
    createTeamOpen.value = false
    myTeamInfo.value = response.data
    viewTeamOpen.value = true
  }).catch(() => { teamLoading.value = false })
}

function submitJoinTeam() {
  if (!joinForm.value.inviteCode.trim()) {
    proxy.$modal.msgError('请输入邀请码')
    return
  }
  teamLoading.value = true
  joinTeam(detail.value.competitionId, joinForm.value.inviteCode.trim()).then(response => {
    proxy.$modal.msgSuccess('成功加入队伍：' + response.data.teamName)
    teamLoading.value = false
    joinTeamOpen.value = false
    myTeamInfo.value = response.data
    viewTeamOpen.value = true
  }).catch(() => { teamLoading.value = false })
}

loadDetail()
</script>

<style scoped>
.detail-page {
  min-height: 100vh;
  background: #f5f7fa;
}

.detail-topbar {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 12px 24px;
  background: #fff;
  box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
  position: sticky;
  top: 0;
  z-index: 100;
}

.detail-topbar .detail-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--el-text-color-primary);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.detail-spacer {
  flex: 1;
}

.detail-content {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px 24px;
}

.hero-card {
  background: #fff;
  border-radius: 12px;
  padding: 28px;
  box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
  margin-bottom: 16px;
}

.badges-row {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
  flex-wrap: wrap;
}

.hero-title {
  font-size: 26px;
  font-weight: 700;
  color: var(--el-text-color-primary);
  margin: 0 0 16px 0;
  line-height: 1.3;
}

.meta-row {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  font-size: 14px;
  color: var(--el-text-color-regular);
  margin-bottom: 14px;
}

.meta-row span {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.tags-row {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
  margin-bottom: 18px;
}

.action-row {
  display: flex;
  align-items: center;
  gap: 12px;
  padding-top: 8px;
  border-top: 1px solid #ebeef5;
}

.full-tip {
  color: #f56c6c;
  font-size: 13px;
}

.deadline-tip {
  color: #e6a23c;
  font-size: 13px;
}

.timeline-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px 28px;
  box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
  margin-bottom: 16px;
}

.card-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--el-text-color-primary);
  margin: 0 0 20px 0;
}

.timeline-track {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  position: relative;
}

.timeline-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
  position: relative;
}

.timeline-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #dcdfe6;
  margin-bottom: 20px;
  z-index: 1;
  flex-shrink: 0;
}

.timeline-dot.active {
  background: #1a73e8;
  box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.15);
}

.timeline-line {
  position: absolute;
  top: 5px;
  left: calc(50% + 8px);
  width: calc(100% - 16px);
  height: 2px;
  background: #dcdfe6;
  z-index: 0;
}

.timeline-line.active {
  background: #1a73e8;
}

.timeline-label {
  font-size: 13px;
  color: var(--el-text-color-regular);
  margin-bottom: 4px;
}

.timeline-date {
  font-size: 12px;
  color: #909399;
}

.detail-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px 28px;
  box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
  margin-bottom: 16px;
}

.rich-body {
  line-height: 1.8;
  color: var(--el-text-color-regular);
  word-break: break-word;
}

.rich-body :deep(p) { margin: 6px 0; }
.rich-body :deep(img) { max-width: 100%; }
.rich-body :deep(strong) { color: var(--el-text-color-primary); }

@media (max-width: 768px) {
  .detail-content { padding: 12px; }
  .hero-card { padding: 16px; }
  .hero-title { font-size: 20px; }
}
</style>
