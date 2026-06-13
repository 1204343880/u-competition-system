<template>
  <div class="app-container">
    <el-table v-loading="loading" :data="teamList">
      <el-table-column label="队名" align="center" prop="teamName" width="160" />
      <el-table-column label="竞赛名称" align="center" prop="competitionName" :show-overflow-tooltip="true" />
      <el-table-column label="队长" align="center" prop="leaderName" width="100" />
      <el-table-column label="指导教师" align="center" prop="teacherName" width="100" />
      <el-table-column label="队伍人数" align="center" prop="currentMembers" width="100" />
      <el-table-column label="队伍状态" align="center" prop="status" width="100">
        <template #default="scope">
          <dict-tag :options="team_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="竞赛进度" align="center" prop="compStatus" width="100">
        <template #default="scope">
          <dict-tag :options="competition_status" :value="scope.row.compStatus" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120" fixed="right">
        <template #default="scope">
          <el-button link type="primary" size="small" @click="handleViewMembers(scope.row)">查看成员</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-empty v-if="!loading && teamList.length === 0" description="暂无指导团队" />

    <el-dialog title="队伍成员" v-model="memberDialogOpen" width="500px" append-to-body>
      <el-table :data="currentMembers" size="small">
        <el-table-column label="姓名" prop="userName" />
        <el-table-column label="昵称" prop="nickName" />
        <el-table-column label="加入时间" width="160">
          <template #default="scope">
            <span>{{ parseTime(scope.row.joinTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup>
import { listTeacherTeams } from '@/api/competition/team'
import { getTeamMembers } from '@/api/competition/team'

const { proxy } = getCurrentInstance()
const { team_status, competition_status } = useDict('team_status', 'competition_status')

const loading = ref(false)
const teamList = ref([])
const memberDialogOpen = ref(false)
const currentMembers = ref([])

function getList() {
  loading.value = true
  listTeacherTeams().then(res => {
    teamList.value = res.data || []
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function handleViewMembers(row) {
  getTeamMembers(row.teamId).then(res => {
    currentMembers.value = res.data || []
    memberDialogOpen.value = true
  })
}

getList()
</script>
