<template>
  <div class="team-square-container">
    <el-form :inline="true" class="search-bar">
      <el-form-item label="按竞赛筛选">
        <el-select v-model="filterCompId" placeholder="全部竞赛" clearable filterable style="width: 280px" @change="getList">
          <el-option v-for="c in competitions" :key="c.competitionId" :label="c.competitionName" :value="c.competitionId" />
        </el-select>
      </el-form-item>
    </el-form>

    <div class="team-grid">
      <el-card v-for="team in teamList" :key="team.teamId" shadow="never" class="team-card">
        <div class="team-card-header">
          <span class="team-card-name">{{ team.teamName }}</span>
          <el-tag type="warning" size="small">{{ team.currentMembers }}/{{ team.maxMembers }}人</el-tag>
        </div>
        <div class="team-card-body">
          <div class="team-info-row">
            <span class="team-info-label">竞赛</span>
            <span class="team-info-value">{{ team.competitionName }}</span>
          </div>
          <div class="team-info-row">
            <span class="team-info-label">类别</span>
            <dict-tag :options="competition_category" :value="team.category" />
          </div>
          <div class="team-info-row" v-if="team.neededSkills">
            <span class="team-info-label">招</span>
            <div class="team-skills-pills">
              <el-tag v-for="s in team.neededSkills.split(',')" :key="s" size="small" type="success">{{ s.trim() }}</el-tag>
            </div>
          </div>
          <div class="team-info-row" v-else>
            <span class="team-info-label"></span>
            <span class="team-no-skills">未指定需求技能</span>
          </div>
          <div class="team-info-row team-leader-row">
            <span class="team-info-label">队长</span>
            <span class="team-leader-name">{{ team.leaderName }}</span>
          </div>
        </div>
        <div class="team-card-footer">
          <el-button type="primary" size="small" @click="handleApplyJoin(team)">申请加入</el-button>
          <el-button size="small" @click="copyInvite(team)">复制邀请码</el-button>
        </div>
      </el-card>
    </div>

    <el-empty v-if="!teamList.length && !loading" description="暂无公开招募的队伍" />

    <el-dialog title="申请加入" v-model="applyDialogOpen" width="450px" append-to-body>
      <div v-if="selectedTeamInfo" style="line-height: 2; font-size: 14px">
        <p>请通过以下方式联系队长 <strong>{{ selectedTeamInfo.leaderName }}</strong>：</p>
        <el-descriptions :column="1" border size="small">
          <el-descriptions-item label="队伍">{{ selectedTeamInfo.teamName }}</el-descriptions-item>
          <el-descriptions-item label="竞赛">{{ selectedTeamInfo.competitionName }}</el-descriptions-item>
          <el-descriptions-item label="邀请码">
            <el-tag type="warning" size="small">{{ selectedTeamInfo.inviteCode }}</el-tag>
            <el-button link type="primary" size="small" style="margin-left: 8px" @click="copyInvite">复制</el-button>
          </el-descriptions-item>
        </el-descriptions>
        <p style="margin-top: 12px; color: #909399">将此邀请码发送给队长，由队长审核后通过</p>
      </div>
      <template #footer>
        <el-button @click="applyDialogOpen = false">关 闭</el-button>
      </template>
    </el-dialog>

    <div class="market-cta">
      <p>还没找到合适的队伍？去人才市场逛逛，也许有队长在等你</p>
      <el-button type="success" @click="goMarket">进入人才市场</el-button>
    </div>
  </div>
</template>

<script setup>
const { proxy } = getCurrentInstance()
const { competition_category } = useDict('competition_category')

const teamList = ref([])
const loading = ref(false)
const competitions = ref([])
const filterCompId = ref(null)
const applyDialogOpen = ref(false)
const selectedTeamInfo = ref(null)

import { listCompetition } from '@/api/competition/hall'
import { getPublicTeams } from '@/api/competition/team'

function loadCompetitions() {
  listCompetition({ pageNum: 1, pageSize: 200, status: '0' }).then(response => {
    competitions.value = response.rows || []
  })
}

function getList() {
  loading.value = true
  getPublicTeams(filterCompId.value || undefined).then(response => {
    teamList.value = response.data || []
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function goMarket() {
  proxy.$router.push('/match/market')
}

function handleApplyJoin(team) {
  selectedTeamInfo.value = team
  applyDialogOpen.value = true
}

function copyInvite(team) {
  navigator.clipboard.writeText(team.inviteCode).then(() => {
    proxy.$modal.msgSuccess('邀请码已复制：' + team.inviteCode)
  }).catch(() => {
    proxy.$modal.msgError('复制失败，请手动记录：' + team.inviteCode)
  })
}

loadCompetitions()
getList()
</script>

<style scoped>
.team-square-container {
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
}

.search-bar {
  margin-bottom: 20px;
}

.team-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 20px;
}

.team-card {
  background: var(--md3-surface);
  border-radius: 16px;
  box-shadow: var(--md3-shadow);
  border: none;
  transition: box-shadow 0.2s ease;
}

.team-card:hover {
  box-shadow: var(--md3-shadow-hover);
}

.team-card :deep(.el-card__body) {
  padding: 0;
}

.team-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid var(--md3-border);
}

.team-card-name {
  font-weight: 600;
  font-size: 16px;
  color: var(--md3-title);
}

.team-card-body {
  padding: 16px 20px;
}

.team-info-row {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
  font-size: 13px;
  line-height: 1.6;
}

.team-info-row:last-child {
  margin-bottom: 0;
}

.team-info-label {
  font-weight: 500;
  color: var(--md3-body);
  flex-shrink: 0;
  min-width: 36px;
}

.team-info-value {
  color: var(--md3-title);
}

.team-skills-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
}

.team-no-skills {
  color: #909399;
  font-size: 12px;
}

.team-leader-row {
  font-size: 12px;
}

.team-leader-name {
  color: var(--md3-body);
}

.team-card-footer {
  display: flex;
  gap: 8px;
  padding: 12px 20px;
  border-top: 1px solid var(--md3-border);
}

.market-cta {
  text-align: center;
  margin-top: 32px;
  padding: 20px;
  background: var(--md3-bg);
  border-radius: 16px;
}

.market-cta p {
  color: var(--md3-body);
  margin-bottom: 10px;
  font-size: 14px;
}

.team-square-container :deep(.el-tag) {
  border: none;
  border-radius: 14px;
}
</style>
