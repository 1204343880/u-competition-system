<template>
  <div class="app-container">
    <el-table v-loading="loading" :data="raceList">
      <el-table-column label="竞赛名称" min-width="200" :show-overflow-tooltip="true">
        <template #default="scope">
          <el-link type="primary" @click="handleDetail(scope.row)">{{ scope.row.competitionName }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="类别" width="90">
        <template #default="scope">
          <dict-tag :options="competition_category" :value="scope.row.category" />
        </template>
      </el-table-column>
      <el-table-column label="类型" align="center" width="70">
        <template #default="scope">
          <el-tag v-if="scope.row.entryType === 'team'" type="warning" size="small">团队</el-tag>
          <el-tag v-else type="primary" size="small">个人</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="队伍名 / 角色" min-width="150" :show-overflow-tooltip="true">
        <template #default="scope">
          <template v-if="scope.row.entryType === 'team'">
            <span v-if="scope.row.userRole === 'leader'" style="color: #f56c6c; font-weight: 600">{{ scope.row.teamName }}</span>
            <span v-else>{{ scope.row.teamName }}</span>
            <el-tag v-if="scope.row.userRole === 'leader'" type="danger" size="small" style="margin-left: 6px">队长</el-tag>
            <el-tag v-else type="info" size="small" style="margin-left: 6px">队员</el-tag>
          </template>
          <span v-else style="color: #909399">-</span>
        </template>
      </el-table-column>
      <el-table-column label="报名/加入时间" align="center" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.entryTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" width="90">
        <template #default="scope">
          <template v-if="scope.row.entryType === 'team'">
            <dict-tag :options="team_status" :value="scope.row.teamStatus" />
          </template>
          <template v-else>
            <dict-tag :options="audit_status" :value="scope.row.auditStatus" />
          </template>
        </template>
      </el-table-column>
      <el-table-column label="竞赛进度" align="center" width="90">
        <template #default="scope">
          <dict-tag :options="competition_status" :value="scope.row.compStatus" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" min-width="130" fixed="right">
        <template #default="scope">
          <el-button
            v-if="scope.row.entryType === 'individual' && scope.row.compStatus === '0'"
            link
            type="danger"
            size="small"
            @click="handleCancelIndividual(scope.row)"
          >取消报名</el-button>
          <template v-if="scope.row.entryType === 'team'">
            <el-button
              v-if="scope.row.compStatus === '0' && scope.row.teamStatus === '0' && scope.row.userRole === 'leader'"
              link
              type="danger"
              size="small"
              @click="handleDisbandTeam(scope.row)"
            >解散队伍</el-button>
            <el-button
              v-if="scope.row.compStatus === '0' && scope.row.teamStatus === '0' && scope.row.userRole !== 'leader'"
              link
              type="danger"
              size="small"
              @click="handleLeaveTeam(scope.row)"
            >退出队伍</el-button>
            <el-button
              link
              type="primary"
              size="small"
              @click="handleViewTeam(scope.row)"
            >查看队伍</el-button>
          </template>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="detailComp.competitionName" v-model="detailOpen" width="700px" append-to-body>
      <div v-if="detailComp.competitionId">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="竞赛名称" :span="2">{{ detailComp.competitionName }}</el-descriptions-item>
          <el-descriptions-item label="类别">
            <dict-tag :options="competition_category" :value="detailComp.category" />
          </el-descriptions-item>
          <el-descriptions-item label="状态">
            <dict-tag :options="competition_status" :value="detailComp.status" />
          </el-descriptions-item>
          <el-descriptions-item label="主办方">{{ detailComp.organizer }}</el-descriptions-item>
          <el-descriptions-item label="承办方">{{ detailComp.host || '-' }}</el-descriptions-item>
          <el-descriptions-item label="报名截止">{{ parseTime(detailComp.applyEndTime) }}</el-descriptions-item>
          <el-descriptions-item label="比赛时间">{{ parseTime(detailComp.startTime) }} ~ {{ parseTime(detailComp.endTime) }}</el-descriptions-item>
          <el-descriptions-item label="竞赛详情" :span="2">
            <div class="rich-content" v-html="detailComp.description || '暂无详情'"></div>
          </el-descriptions-item>
        </el-descriptions>
      </div>
      <template #footer>
        <el-button @click="detailOpen = false">关 闭</el-button>
      </template>
    </el-dialog>

    <!-- 查看队伍弹窗 -->
    <el-dialog title="队伍详情" v-model="teamDialogOpen" width="600px" append-to-body>
      <div v-if="selectedTeam">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="队伍名称" :span="2">{{ selectedTeam.teamName }}</el-descriptions-item>
          <el-descriptions-item label="邀请码">
            <el-tag type="warning">{{ selectedTeam.inviteCode }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="队伍人数">{{ selectedTeam.memberCount }} / {{ selectedTeam.maxMembers }}</el-descriptions-item>
          <el-descriptions-item label="队伍状态">
            <dict-tag :options="team_status" :value="selectedTeam.teamStatus" />
          </el-descriptions-item>
          <el-descriptions-item v-if="selectedTeam.userRole === 'leader'" label="公开招募" :span="2">
            <el-switch v-model="selectedTeam.isPublic" active-value="1" inactive-value="0" @change="toggleRaceTeamPublic" />
            <span style="margin-left: 8px; font-size: 12px; color: #909399">开启后在组队广场展示</span>
          </el-descriptions-item>
          <el-descriptions-item v-if="selectedTeam.userRole === 'leader'" label="所需技能" :span="2">
            <el-button link type="primary" size="small" @click="skillDialogOpen = true">
              {{ raceTeamSkills || '点击选择所需技能' }}
            </el-button>
          </el-descriptions-item>
        </el-descriptions>

        <el-divider content-position="left">队伍成员</el-divider>
        <el-table :data="dialogTeamMembers" size="small">
          <el-table-column label="姓名" prop="userName" />
          <el-table-column label="昵称" prop="nickName" />
          <el-table-column label="加入时间" width="160">
            <template #default="scope">{{ parseTime(scope.row.joinTime) }}</template>
          </el-table-column>
          <el-table-column label="角色" min-width="110">
            <template #default="scope">
              <el-tag v-if="scope.row.userId === selectedTeam.leaderId" type="danger" size="small">队长</el-tag>
              <template v-else>
                <el-tag type="info" size="small">队员</el-tag>
                <el-button
                  v-if="selectedTeam.userRole === 'leader'"
                  link
                  type="warning"
                  size="small"
                  style="margin-left: 8px"
                  @click="handleRaceTransferLeader(scope.row)"
                >移交队长</el-button>
              </template>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <template #footer>
        <el-button @click="teamDialogOpen = false">关 闭</el-button>
      </template>
    </el-dialog>

    <SkillSelector v-model="skillDialogOpen" :current-skills="raceTeamSkills" @save="onRaceSkillSave" />
  </div>
</template>

<script setup>

const { proxy } = getCurrentInstance()
const { competition_status, competition_category, audit_status, team_status }
  = useDict('competition_status', 'competition_category', 'audit_status', 'team_status')

const raceList = ref([])
const loading = ref(false)
const total = ref(0)
const detailOpen = ref(false)
const detailComp = ref({})
const teamDialogOpen = ref(false)
const selectedTeam = ref(null)
const dialogTeamMembers = ref([])

const raceTeamSkills = ref('')
const skillDialogOpen = ref(false)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

import { listMyApplies, getCompetition, cancelApply } from '@/api/competition/hall'
import { getMyTeams, getTeamMembers, leaveTeam, disbandTeam, transferLeader, toggleTeamPublic, updateTeamSkills } from '@/api/competition/team'
import SkillSelector from '@/views/student/hall/SkillSelector.vue'

function getList() {
  loading.value = true
  Promise.all([
    listMyApplies().catch(() => ({ data: [] })),
    getMyTeams().catch(() => ({ data: [] }))
  ]).then(([applyRes, teamRes]) => {
    const merged = []

    const applies = applyRes.data || []
    applies.forEach(a => {
      merged.push({
        ...a,
        entryType: 'individual',
        entryTime: a.applyTime
      })
    })

    const teams = teamRes.data || []
    teams.forEach(t => {
      merged.push({
        competitionId: t.competitionId,
        competitionName: t.competitionName,
        category: t.category,
        categoryName: t.categoryName,
        compStatus: t.compStatus,
        entryType: 'team',
        entryTime: t.joinTime,
        teamId: t.teamId,
        teamName: t.teamName,
        leaderId: t.leaderId,
        userRole: t.userRole,
        teamStatus: t.status,
        memberCount: t.currentMembers,
        maxMembers: t.maxMembers,
        inviteCode: t.inviteCode,
        isPublic: t.isPublic || '0',
        neededSkills: t.neededSkills || '',
        auditStatus: t.status
      })
    })

    merged.sort((a, b) => {
      const tA = a.entryTime ? new Date(a.entryTime).getTime() : 0
      const tB = b.entryTime ? new Date(b.entryTime).getTime() : 0
      return tB - tA
    })

    raceList.value = merged
    total.value = merged.length
    loading.value = false
  })
}

function handleDetail(row) {
  getCompetition(row.competitionId).then(response => {
    detailComp.value = response.data
    detailOpen.value = true
  })
}

function handleCancelIndividual(row) {
  proxy.$modal.confirm('确定要取消对【' + row.competitionName + '】的报名吗？取消后将无法恢复。', '提示', {
    confirmButtonText: '确定取消',
    cancelButtonText: '暂不取消',
    type: 'warning'
  }).then(() => {
    return cancelApply(row.competitionId)
  }).then(() => {
    proxy.$modal.msgSuccess('取消报名成功')
    getList()
  })
}

function handleLeaveTeam(row) {
  proxy.$modal.confirm('确定要退出队伍【' + row.teamName + '】吗？退出后可重新加入其他队伍。', '提示', {
    confirmButtonText: '确定退出',
    cancelButtonText: '暂不退出',
    type: 'warning'
  }).then(() => {
    return leaveTeam(row.teamId)
  }).then(() => {
    proxy.$modal.msgSuccess('已退出队伍')
    getList()
  })
}

function handleDisbandTeam(row) {
  proxy.$modal.confirm('确定要解散队伍【' + row.teamName + '】吗？队伍所有成员的记录将被移除，此操作不可恢复。', '警告', {
    confirmButtonText: '确定解散',
    cancelButtonText: '再想想',
    type: 'error'
  }).then(() => {
    return disbandTeam(row.teamId)
  }).then(() => {
    proxy.$modal.msgSuccess('队伍已解散')
    getList()
  })
}

function handleViewTeam(row) {
  selectedTeam.value = row
  teamDialogOpen.value = true
  raceTeamSkills.value = row.neededSkills || ''
  getTeamMembers(row.teamId).then(response => {
    dialogTeamMembers.value = response.data || []
  })
}

function toggleRaceTeamPublic(val) {
  toggleTeamPublic(selectedTeam.value.teamId, val === '1').then(() => {
    proxy.$modal.msgSuccess(val === '1' ? '已公开招募' : '已关闭公开招募')
  })
}

function saveRaceSkills() {
  updateTeamSkills(selectedTeam.value.teamId, raceTeamSkills.value).then(() => {
    proxy.$modal.msgSuccess('技能已更新')
    getList()
  })
}

function onRaceSkillSave(skills) {
  raceTeamSkills.value = skills
  saveRaceSkills()
}

function handleRaceTransferLeader(member) {
  proxy.$modal.confirm('确定将队长移交给【' + member.userName + '】吗？移交后你将失去队长权限。', '提示', {
    confirmButtonText: '确定移交',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    return transferLeader(selectedTeam.value.teamId, member.userId)
  }).then(() => {
    proxy.$modal.msgSuccess('队长已移交')
    getList()
    teamDialogOpen.value = false
  })
}

getList()
</script>

<style scoped>
.rich-content {
  max-height: 300px;
  overflow-y: auto;
  line-height: 1.8;
}
.rich-content :deep(p) {
  margin: 4px 0;
}
</style>
