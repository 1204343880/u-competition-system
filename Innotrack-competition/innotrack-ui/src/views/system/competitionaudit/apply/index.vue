<template>
  <div class="app-container">
    <el-form :model="queryParams" :inline="true">
      <el-form-item label="审核状态">
        <el-select v-model="queryParams.auditStatus" placeholder="全部" clearable>
          <el-option label="待审核" value="0" />
          <el-option label="已通过" value="1" />
          <el-option label="已拒绝" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="姓名">
        <el-input v-model="queryParams.userName" placeholder="请输入姓名" clearable @keyup.enter="getList" />
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
      <el-table-column label="竞赛名称" align="center" prop="competitionName" :show-overflow-tooltip="true" />
      <el-table-column label="报名人" align="center" prop="userName" width="100" />
      <el-table-column label="昵称" align="center" prop="nickName" width="100" />
      <el-table-column label="报名时间" align="center" prop="applyTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.applyTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="auditStatus" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.auditStatus === '0'" type="warning">待审核</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '1'" type="success">已通过</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '2'" type="danger">已拒绝</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核人" align="center" prop="auditBy" width="100">
        <template #default="scope">
          <span>{{ scope.row.auditBy || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" align="center" prop="auditTime" width="160">
        <template #default="scope">
          <span>{{ scope.row.auditTime ? parseTime(scope.row.auditTime) : '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="scope">
          <el-button v-if="scope.row.auditStatus === '0'" link type="success" icon="Select" @click="handleAudit(scope.row, '1')">通过</el-button>
          <el-button v-if="scope.row.auditStatus === '0'" link type="danger" icon="Close" @click="handleAudit(scope.row, '2')">拒绝</el-button>
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
  </div>
</template>

<script setup>
import { listApplyAudit, auditApply } from '@/api/competition/audit'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const list = ref([])
const total = ref(0)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  auditStatus: '0',
  userName: '',
  competitionName: ''
})

function getList() {
  loading.value = true
  listApplyAudit(queryParams.value).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => { loading.value = false })
}

function resetQuery() {
  queryParams.value = { pageNum: 1, pageSize: 10, auditStatus: '0', userName: '', competitionName: '' }
  getList()
}

function handleAudit(row, status) {
  const label = status === '1' ? '通过' : '拒绝'
  proxy.$modal.confirm(`确认${label}该报名？`).then(() => {
    return auditApply({ applyId: row.applyId, auditStatus: status })
  }).then(() => {
    proxy.$modal.msgSuccess(`已${label}`)
    getList()
  })
}

getList()
</script>
