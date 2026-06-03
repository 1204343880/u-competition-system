<template>
  <div class="app-container">
    <el-form :inline="true" class="search-bar">
      <el-form-item label="按竞赛筛选">
        <el-select v-model="filterCompId" placeholder="全部竞赛" clearable filterable style="width: 280px" @change="getList">
          <el-option v-for="c in competitions" :key="c.competitionId" :label="c.competitionName" :value="c.competitionId" />
        </el-select>
      </el-form-item>
    </el-form>

    <el-row :gutter="16">
      <el-col v-for="team in teamList" :key="team.teamId" :span="8" style="margin-bottom: 16px">
        <el-card shadow="hover">
          <template #header>
            <div style="display: flex; justify-content: space-between; align-items: center">
              <span style="font-weight: 600; font-size: 15px">{{ team.teamName }}</span>
              <el-tag type="warning" size="small">{{ team.currentMembers }}/{{ team.maxMembers }}人</el-tag>
            </div>
          </template>
          <div class="team-info">
            <p><strong>竞赛：</strong>{{ team.competitionName }}</p>
            <p><strong>类别：</strong><dict-tag :options="competition_category" :value="team.category" /></p>
            <p v-if="team.neededSkills">
              <strong>招：</strong>
              <el-tag v-for="s in team.neededSkills.split(',')" :key="s" size="small" type="success" style="margin-right: 4px">{{ s.trim() }}</el-tag>
            </p>
            <p v-else style="color: #909399">未指定需求技能</p>
            <p style="color: #909399; font-size: 12px">队长：{{ team.leaderName }}</p>
          </div>
          <template #footer>
            <el-button type="primary" size="small" @click="handleApplyJoin(team)">申请加入</el-button>
            <el-button size="small" @click="copyInvite(team)">复制邀请码</el-button>
          </template>
        </el-card>
      </el-col>
    </el-row>

    <el-empty v-if="!teamList.length && !loading" description="暂无公开招募的队伍" />

    <!-- 申请加入弹窗 -->
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

    <!-- 人才市场入口 -->
    <div style="text-align: center; margin-top: 30px; padding: 20px; background: #f5f7fa; border-radius: 4px">
      <p style="color: #606266; margin-bottom: 10px">还没找到合适的队伍？去人才市场逛逛，也许有队长在等你</p>
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
.search-bar {
  margin-bottom: 16px;
}
.team-info p {
  margin: 6px 0;
  font-size: 13px;
}
</style>
