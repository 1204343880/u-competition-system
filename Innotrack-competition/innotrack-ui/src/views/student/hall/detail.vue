<template>
  <div class="detail-page" v-loading="loading">
    <div
      class="hero-banner"
      :style="{ backgroundImage: detail.coverImage ? `url(${detail.coverImage})` : undefined }"
    >
      <el-breadcrumb class="hero-breadcrumb" separator="/">
        <el-breadcrumb-item :to="{ path: '/index' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item @click="goBack">竞赛大厅</el-breadcrumb-item>
        <el-breadcrumb-item>{{ detail.competitionName }}</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="hero-body">
        <div class="hero-badges">
          <dict-tag :options="competition_category" :value="detail.category" />
          <dict-tag :options="competition_level" :value="detail.competitionLevel" />
          <dict-tag :options="competition_type" :value="detail.competitionType" />
          <dict-tag :options="competition_status" :value="detail.status" />
        </div>
        <h1 class="hero-title">{{ detail.competitionName }}</h1>
        <div class="hero-meta">
          <span v-if="detail.organizer"><el-icon><UserFilled /></el-icon> {{ detail.organizer }}</span>
          <span v-if="detail.host"><el-icon><OfficeBuilding /></el-icon> {{ detail.host }}</span>
          <span><el-icon><View /></el-icon> {{ formatViewCount(detail.viewCount) }} 浏览</span>
          <span><el-icon><Avatar /></el-icon> {{ detail.currentParticipants || 0 }}/{{ detail.maxParticipants || '不限' }} 人</span>
        </div>
      </div>

      <div class="hero-cta">
        <template v-if="detail.status === '0'">
          <template v-if="detail.competitionType === '1'">
            <el-button size="large" type="primary" :disabled="isFull" @click="handleApply">
              {{ isFull ? '名额已满' : '立即报名' }}
            </el-button>
          </template>
          <template v-else-if="detail.competitionType === '2'">
            <el-button v-if="!myTeamInfo" size="large" type="primary" @click="handleCreateTeam">创建队伍</el-button>
            <el-button v-if="!myTeamInfo" size="large" plain @click="handleJoinTeam">加入队伍</el-button>
            <el-button v-if="myTeamInfo" size="large" type="primary" @click="handleViewTeam">查看我的队伍</el-button>
          </template>
        </template>
        <el-tag v-else size="large" type="warning" effect="dark">报名已截止</el-tag>
      </div>
    </div>

    <div class="main-grid" v-if="detail.competitionId">
      <div class="main-left">
        <el-tabs v-model="activeTab" class="detail-tabs">
          <el-tab-pane label="竞赛规程" name="description">
            <div v-if="detail.description" class="rich-body" v-html="detail.description"></div>
            <EmptyState v-else description="暂无详细规程" :show-image="false" />
          </el-tab-pane>
          <el-tab-pane label="赛程安排" name="schedule">
            <div class="schedule-list">
              <div
                v-for="node in timelineItems"
                :key="node.label"
                class="schedule-item"
                :class="{ active: node.active }"
              >
                <div class="schedule-dot"></div>
                <div class="schedule-info">
                  <span class="schedule-label">{{ node.label }}</span>
                  <span class="schedule-date">{{ node.date || '待定' }}</span>
                </div>
              </div>
              <EmptyState v-if="!timelineItems.length" description="暂无赛程安排" :show-image="false" />
            </div>
          </el-tab-pane>
          <el-tab-pane label="奖项设置" name="prize">
            <EmptyState description="暂未公布奖项信息" :show-image="false" />
          </el-tab-pane>
        </el-tabs>
      </div>

      <div class="main-right">
        <div class="sidebar-card">
          <h3 class="sidebar-title">关键时间</h3>
          <el-timeline v-if="timelineItems.length">
            <el-timeline-item
              v-for="node in timelineItems"
              :key="node.label"
              :timestamp="node.date || '待定'"
              :color="node.active ? '#1a73e8' : '#dcdfe6'"
              placement="top"
            >
              {{ node.label }}
            </el-timeline-item>
          </el-timeline>
          <EmptyState v-else description="暂无时间信息" :show-image="false" />
        </div>
      </div>
    </div>

    <EmptyState
      v-if="!loading && !detail.competitionId"
      description="无法加载竞赛信息，请返回重试"
    />

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
import { UserFilled, OfficeBuilding, View, Avatar } from '@element-plus/icons-vue'
import { useRouter, useRoute } from 'vue-router'
import useUserStore from '@/store/modules/user'
import { getCompetition, applyCompetition } from '@/api/competition/hall'
import { createTeam, joinTeam, getMyTeam } from '@/api/competition/team'
import { parseTime } from '@/utils/ruoyi'

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
const activeTab = ref('description')

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

const timelineItems = computed(() => {
  const d = detail.value
  if (!d) return []
  const fmt = (val) => val ? parseTime(val, '{y}-{m}-{d} {h}:{i}') : ''
  const now = Date.now()
  const items = []
  if (d.applyStartTime) {
    items.push({ label: '报名开始', date: fmt(d.applyStartTime), active: now >= new Date(d.applyStartTime).getTime() })
  }
  if (d.applyEndTime) {
    items.push({ label: '报名截止', date: fmt(d.applyEndTime), active: now >= new Date(d.applyEndTime).getTime() })
  }
  if (d.startTime) {
    items.push({ label: '比赛开始', date: fmt(d.startTime), active: now >= new Date(d.startTime).getTime() })
  }
  if (d.endTime) {
    items.push({ label: '比赛结束', date: fmt(d.endTime), active: now >= new Date(d.endTime).getTime() })
  }
  return items
})

function goBack() {
  router.back()
}

function formatViewCount(count) {
  if (!count) return '0'
  if (count > 10000) return (count / 10000).toFixed(1) + '万'
  return String(count)
}

function loadDetail() {
  const competitionId = route.params.competitionId
  if (competitionId == null || competitionId === '') {
    loading.value = false
    return
  }
  loading.value = true
  try {
    getCompetition(competitionId).then(response => {
      detail.value = response.data
      loading.value = false
      if (detail.value && detail.value.competitionType === '2') {
        checkMyTeam()
      }
    }).catch(() => {
      loading.value = false
    })
  } catch (e) {
    loading.value = false
  }
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
  min-height: 100dvh;
  background: transparent;
}

.hero-banner {
  height: 260px;
  background: linear-gradient(135deg, #1a73e8 0%, #1557b0 40%, #0d47a1 100%);
  background-size: cover;
  background-position: center;
  position: relative;
  padding: 24px 40px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 18px;
  box-shadow: 0 10px 28px rgba(26, 77, 138, 0.12);
  margin-bottom: 32px;
}

.hero-banner::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(0, 0, 0, 0.15) 0%, rgba(0, 0, 0, 0.65) 100%);
  z-index: 0;
}

.hero-breadcrumb {
  position: relative;
  z-index: 1;
}

.hero-breadcrumb :deep(.el-breadcrumb__inner) {
  color: rgba(255, 255, 255, 0.8);
}

.hero-breadcrumb :deep(.el-breadcrumb__inner.is-link:hover) {
  color: #fff;
}

.hero-breadcrumb :deep(.el-breadcrumb__item:last-child .el-breadcrumb__inner) {
  color: #fff;
  font-weight: 500;
}

.hero-body {
  position: relative;
  z-index: 1;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 12px;
}

.hero-badges {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.hero-title {
  font-size: 32px;
  font-weight: 800;
  color: #fff;
  margin: 0;
  line-height: 1.25;
  text-shadow: 0 1px 4px rgba(0, 0, 0, 0.3);
}

.hero-meta {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.85);
}

.hero-meta span {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.hero-cta {
  position: absolute;
  right: 40px;
  bottom: 24px;
  z-index: 1;
}

.hero-cta .el-button--large {
  border-radius: 8px;
  font-weight: 600;
  padding: 12px 32px;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.hero-cta .el-button--large:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 16px rgba(26, 115, 232, 0.4);
}

.hero-cta .el-button--large.is-plain {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.5);
  color: #fff;
}

.hero-cta .el-button--large.is-plain:hover {
  background: rgba(255, 255, 255, 0.25);
  border-color: #fff;
}

.main-grid {
  max-width: 1280px;
  margin: -24px auto 0;
  padding: 0 24px 40px;
  display: grid;
  grid-template-columns: 1fr 340px;
  gap: 24px;
  align-items: start;
  position: relative;
  z-index: 2;
}

.main-left {
  background: #fff;
  border-radius: 16px;
  box-shadow: var(--student-shadow, 0 1px 2px rgba(41,45,52,.04));
  padding: 8px 0;
  min-height: 400px;
}

.detail-tabs :deep(.el-tabs__header) {
  margin: 0 24px;
}

.detail-tabs :deep(.el-tabs__nav-wrap::after) {
  height: 1px;
  background-color: #f0f2f5;
}

.detail-tabs :deep(.el-tabs__content) {
  padding: 8px 24px 24px;
}

.main-right {
  position: sticky;
  top: 24px;
}

.sidebar-card {
  background: #fff;
  border-radius: 16px;
  padding: 20px 24px;
  box-shadow: var(--student-shadow, 0 1px 2px rgba(41,45,52,.04));
}

.sidebar-title {
  font-size: 16px;
  font-weight: 600;
  color: #202124;
  margin: 0 0 16px 0;
}

.schedule-list {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.schedule-item {
  display: flex;
  gap: 14px;
  padding: 10px 0;
  position: relative;
}

.schedule-item:not(:last-child)::after {
  content: '';
  position: absolute;
  left: 5px;
  top: 26px;
  width: 2px;
  height: calc(100% - 4px);
  background: #e0e0e0;
}

.schedule-item.active:not(:last-child)::after {
  background: #1a73e8;
}

.schedule-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #dcdfe6;
  flex-shrink: 0;
  margin-top: 3px;
  z-index: 1;
}

.schedule-item.active .schedule-dot {
  background: #1a73e8;
  box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.12);
}

.schedule-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.schedule-label {
  font-size: 14px;
  color: #202124;
  font-weight: 500;
}

.schedule-date {
  font-size: 12px;
  color: #909399;
}

.rich-body {
  line-height: 1.9;
  color: #3c4043;
  font-size: 15px;
  word-break: break-word;
}

.rich-body :deep(p) { margin: 10px 0; }
.rich-body :deep(img) { max-width: 100%; border-radius: 6px; margin: 12px 0; }
.rich-body :deep(table) { width: 100%; border-collapse: collapse; margin: 12px 0; }
.rich-body :deep(td), .rich-body :deep(th) { border: 1px solid #e0e0e0; padding: 10px 14px; text-align: left; }
.rich-body :deep(th) { background: #f8f9fa; font-weight: 600; color: #202124; }
.rich-body :deep(strong) { color: #202124; }
.rich-body :deep(ul), .rich-body :deep(ol) { padding-left: 24px; }
.rich-body :deep(a) { color: #1a73e8; }
.rich-body :deep(h2), .rich-body :deep(h3) { color: #202124; margin: 16px 0 8px; }

@media (max-width: 900px) {
  .hero-banner {
    height: 200px;
    padding: 16px 20px;
  }

  .hero-title {
    font-size: 22px;
  }

  .hero-cta {
    right: 20px;
    bottom: 16px;
  }

  .main-grid {
    grid-template-columns: 1fr;
    padding: 0 12px 24px;
  }
}
</style>
