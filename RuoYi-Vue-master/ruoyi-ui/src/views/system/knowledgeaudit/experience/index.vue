<template>
  <div class="app-container">
    <el-form :model="queryParams" :inline="true">
      <el-form-item label="审核状态">
        <el-select v-model="queryParams.auditStatus" placeholder="全部" clearable>
          <el-option label="待审核" value="0" />
          <el-option label="已通过" value="1" />
          <el-option label="已驳回" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="标题">
        <el-input v-model="queryParams.title" placeholder="请输入标题" clearable @keyup.enter="getList" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="getList">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="list">
      <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
      <el-table-column label="作者" align="center" prop="author" width="100" />
      <el-table-column label="分类" align="center" prop="category" width="120">
        <template #default="scope">
          <el-tag size="small">{{ scope.row.category }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="投稿人" align="center" prop="createBy" width="100" />
      <el-table-column label="投稿时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="auditStatus" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.auditStatus === '0'" type="warning">待审核</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '1'" type="success">已通过</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '2'" type="danger">已驳回</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核人" align="center" prop="auditBy" width="100">
        <template #default="scope">
          <span>{{ scope.row.auditBy || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" align="center" prop="auditTime" width="180">
        <template #default="scope">
          <span>{{ scope.row.auditTime ? parseTime(scope.row.auditTime) : '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="240">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button v-if="scope.row.auditStatus === '0'" link type="success" icon="Select" @click="handleAudit(scope.row, '1')">通过</el-button>
          <el-button v-if="scope.row.auditStatus === '0'" link type="danger" icon="Close" @click="handleAudit(scope.row, '2')">驳回</el-button>
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

    <el-dialog title="经验帖详情" v-model="detailVisible" width="800px">
      <div class="detail-header">
        <h2>{{ detail.title }}</h2>
        <div class="detail-meta">
          <span>作者：{{ detail.author }}</span>
          <span>分类：<el-tag size="small">{{ detail.category }}</el-tag></span>
          <span>发布时间：{{ parseTime(detail.createTime) }}</span>
          <span>浏览：{{ detail.viewCount }}</span>
        </div>
      </div>
      <el-divider />
      <div class="detail-content" v-html="detail.content" style="padding:16px; background:#fafafa; border-radius:4px; min-height:100px;"></div>
    </el-dialog>
  </div>
</template>

<script setup>
import { listAuditExperience, auditExperience, getAuditExperience } from '@/api/competition/knowledge'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const list = ref([])
const total = ref(0)
const detailVisible = ref(false)
const detail = ref({})

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  auditStatus: '0',
  title: ''
})

function getList() {
  loading.value = true
  listAuditExperience(queryParams.value).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => { loading.value = false })
}

function resetQuery() {
  queryParams.value = { pageNum: 1, pageSize: 10, auditStatus: '0', title: '' }
  getList()
}

function handleView(row) {
  getAuditExperience(row.experienceId).then(res => {
    detail.value = res.data
    detailVisible.value = true
  })
}

function handleAudit(row, status) {
  const label = status === '1' ? '通过' : '驳回'
  proxy.$modal.confirm(`确认${label}该经验帖？`).then(() => {
    return auditExperience({ experienceId: row.experienceId, auditStatus: status })
  }).then(() => {
    proxy.$modal.msgSuccess(`已${label}`)
    getList()
  })
}

getList()
</script>

<style scoped>
.detail-header h2 { margin: 0 0 12px 0; font-size: 20px; }
.detail-meta { display: flex; gap: 20px; font-size: 13px; color: #909399; align-items: center; }
</style>
