<template>
  <div class="app-container">
    <el-form :model="queryParams" :inline="true">
      <el-form-item label="队伍状态">
        <el-select v-model="queryParams.status" placeholder="全部" clearable>
          <el-option label="组队中" value="0" />
          <el-option label="已提交" value="1" />
          <el-option label="审核通过" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="队伍名称">
        <el-input v-model="queryParams.teamName" placeholder="请输入队伍名称" clearable @keyup.enter="getList" />
      </el-form-item>
      <el-form-item label="竞赛名称">
        <el-input v-model="queryParams.competitionName" placeholder="请输入竞赛名称" clearable @keyup.enter="getList" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="getList">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="list">
      <el-table-column label="队伍名称" align="center" prop="teamName" width="160" />
      <el-table-column label="竞赛名称" align="center" prop="competitionName" :show-overflow-tooltip="true" />
      <el-table-column label="队长" align="center" prop="leaderName" width="100" />
      <el-table-column label="队伍人数" align="center" width="100">
        <template #default="scope">
          <span>{{ scope.row.currentMembers }} / {{ scope.row.maxMembers }}</span>
        </template>
      </el-table-column>
      <el-table-column label="指导教师" align="center" prop="teacherName" width="100">
        <template #default="scope">
          <span>{{ scope.row.teacherName || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="队伍状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="info">组队中</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="warning">已提交</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="success">审核通过</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="240" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看成员</el-button>
          <template v-if="scope.row.status === '1'">
            <el-button link type="success" icon="Select" @click="handleAudit(scope.row, '2')">通过</el-button>
            <el-button link type="danger" icon="Close" @click="handleAudit(scope.row, '0')">驳回</el-button>
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

    <el-dialog title="队伍成员" v-model="memberVisible" width="500px" append-to-body>
      <el-table :data="members" size="small">
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
import { listTeamAudit, auditTeam } from '@/api/competition/audit'
import { getTeamDetail } from '@/api/competition/team'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const list = ref([])
const total = ref(0)
const memberVisible = ref(false)
const members = ref([])

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  status: '1',
  teamName: '',
  competitionName: ''
})

function getList() {
  loading.value = true
  listTeamAudit(queryParams.value).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => { loading.value = false })
}

function resetQuery() {
  queryParams.value = { pageNum: 1, pageSize: 10, status: '1', teamName: '', competitionName: '' }
  getList()
}

function handleView(row) {
  getTeamDetail(row.teamId).then(res => {
    members.value = res.data || []
    memberVisible.value = true
  })
}

function handleAudit(row, status) {
  const label = status === '2' ? '通过' : '驳回'
  proxy.$modal.confirm(`确认${label}该队伍？`).then(() => {
    return auditTeam({ teamId: row.teamId, status: status })
  }).then(() => {
    proxy.$modal.msgSuccess(`已${label}`)
    getList()
  })
}

getList()
</script>
