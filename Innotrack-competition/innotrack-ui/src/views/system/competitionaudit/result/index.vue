<template>
  <div class="app-container">
    <el-form :model="queryParams" :inline="true">
      <el-form-item label="审核状态">
        <el-select v-model="queryParams.resultStatus" placeholder="全部" clearable>
          <el-option label="待审核" value="0" />
          <el-option label="已确认" value="1" />
          <el-option label="已作废" value="2" />
        </el-select>
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
      <el-table-column label="参赛项目" align="center" prop="projectName" :show-overflow-tooltip="true" />
      <el-table-column label="队伍" align="center" prop="teamName" width="140">
        <template #default="scope">
          <span>{{ scope.row.teamName || scope.row.userName || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="获奖级别" align="center" prop="awardLevel" width="140">
        <template #default="scope">
          <el-tag type="warning" size="small">{{ scope.row.awardLevel }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="录入人" align="center" prop="createBy" width="100" />
      <el-table-column label="录入时间" align="center" prop="createTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="resultStatus" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.resultStatus === '0'" type="warning">待审核</el-tag>
          <el-tag v-else-if="scope.row.resultStatus === '1'" type="success">已确认</el-tag>
          <el-tag v-else-if="scope.row.resultStatus === '2'" type="danger">已作废</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核人" align="center" prop="auditBy" width="100">
        <template #default="scope">
          <span>{{ scope.row.auditBy || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <template v-if="scope.row.resultStatus === '0'">
            <el-button link type="success" icon="Select" @click="handleAudit(scope.row, '1')">通过</el-button>
            <el-button link type="danger" icon="Close" @click="handleAudit(scope.row, '2')">驳回</el-button>
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

    <el-dialog title="成绩详情" v-model="detailVisible" width="600px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="竞赛名称">{{ detail.competitionName }}</el-descriptions-item>
        <el-descriptions-item label="参赛项目">{{ detail.projectName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="获奖级别">{{ detail.awardLevel }}</el-descriptions-item>
        <el-descriptions-item label="排名">{{ detail.ranking || '-' }}</el-descriptions-item>
        <el-descriptions-item label="分数">{{ detail.score || '-' }}</el-descriptions-item>
        <el-descriptions-item label="录入人">{{ detail.createBy }}</el-descriptions-item>
        <el-descriptions-item label="录入时间">{{ parseTime(detail.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="审核人">{{ detail.auditBy || '-' }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup>
import { listResultAudit, auditResult } from '@/api/competition/audit'
import { getResult } from '@/api/competition/result'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const list = ref([])
const total = ref(0)
const detailVisible = ref(false)
const detail = ref({})

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  resultStatus: '0',
  competitionName: ''
})

function getList() {
  loading.value = true
  listResultAudit(queryParams.value).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => { loading.value = false })
}

function resetQuery() {
  queryParams.value = { pageNum: 1, pageSize: 10, resultStatus: '0', competitionName: '' }
  getList()
}

function handleView(row) {
  getResult(row.resultId).then(res => {
    detail.value = res.data
    detailVisible.value = true
  })
}

function handleAudit(row, status) {
  const label = status === '1' ? '通过' : '驳回'
  proxy.$modal.confirm(`确认${label}该成绩记录？`).then(() => {
    return auditResult({ resultId: row.resultId, resultStatus: status })
  }).then(() => {
    proxy.$modal.msgSuccess(`已${label}`)
    getList()
  })
}

getList()
</script>
