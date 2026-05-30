<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="竞赛名称" prop="competitionName">
        <el-input v-model="queryParams.competitionName" placeholder="请输入竞赛名称" clearable style="width: 240px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="竞赛状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择竞赛状态" clearable style="width: 160px">
          <el-option label="全部" value="" />
          <el-option label="报名中" value="0" />
          <el-option label="进行中" value="1" />
          <el-option label="已结束" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleApply" v-hasPermi="['competition:student:apply']">报名竞赛</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" :columns="columns" storageKey="competition-portal"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="竞赛编号" align="center" prop="competitionId" v-if="columns.competitionId.visible" />
      <el-table-column label="竞赛名称" align="center" v-if="columns.competitionName.visible" :show-overflow-tooltip="true">
        <template #default="scope">
          <a class="link-type" style="cursor:pointer" @click="handleDetail(scope.row)">{{ scope.row.competitionName }}</a>
        </template>
      </el-table-column>
      <el-table-column label="竞赛类别" align="center" prop="categoryName" v-if="columns.categoryName.visible" />
      <el-table-column label="报名截止" align="center" prop="registerEnd" v-if="columns.registerEnd.visible" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.registerEnd) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="竞赛状态" align="center" v-if="columns.status.visible">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : (scope.row.status === '1' ? 'warning' : 'info')">
            {{ scope.row.status === '0' ? '报名中' : (scope.row.status === '1' ? '进行中' : '已结束') }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-tooltip content="详情" placement="top">
            <el-button link type="primary" icon="Search" @click="handleDetail(scope.row)"></el-button>
          </el-tooltip>
          <el-tooltip content="报名" placement="top">
            <el-button link type="primary" icon="Plus" @click="handleApply(scope.row)" v-hasPermi="['competition:student:apply']" v-if="scope.row.status === '0'"></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="'竞赛详情'" v-model="detailOpen" width="700px" append-to-body>
      <div v-if="currentCompetition">
        <h3>{{ currentCompetition.competitionName }}</h3>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="竞赛类别">{{ currentCompetition.categoryName }}</el-descriptions-item>
          <el-descriptions-item label="竞赛状态">
            <el-tag :type="currentCompetition.status === '0' ? 'success' : 'info'">{{ currentCompetition.status === '0' ? '报名中' : '已结束' }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="报名截止">{{ parseTime(currentCompetition.registerEnd) }}</el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ parseTime(currentCompetition.createTime) }}</el-descriptions-item>
          <el-descriptions-item label="竞赛描述" :span="2">{{ currentCompetition.description || '暂无描述' }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listPortalCompetition, getCompetition } from '@/api/competition/portal'
import { parseTime } from '@/utils/ruoyi'
import Pagination from '@/components/Pagination'
import RightToolbar from '@/components/RightToolbar'

const proxy = window.proxy
const loading = ref(true)
const total = ref(0)
const showSearch = ref(true)
const ids = ref([])
const detailOpen = ref(false)
const currentCompetition = ref(null)
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  competitionName: '',
  status: ''
})
const columns = reactive({
  competitionId: { visible: true },
  competitionName: { visible: true },
  categoryName: { visible: true },
  registerEnd: { visible: true },
  status: { visible: true }
})

const competitionList = ref([])

function getList() {
  loading.value = true
  listPortalCompetition(queryParams).then(response => {
    competitionList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function handleQuery() {
  queryParams.pageNum = 1
  getList()
}

function resetQuery() {
  queryParams.competitionName = ''
  queryParams.status = ''
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.competitionId)
}

function handleDetail(row) {
  getCompetition(row.competitionId).then(response => {
    currentCompetition.value = response.data
    detailOpen.value = true
  })
}

function handleApply(row) {
  proxy.$modal.confirm('是否确认报名竞赛"' + (row?.competitionName || '') + '"？').then(() => {
    proxy.$modal.msgSuccess("报名申请已提交")
  })
}

onMounted(() => {
  getList()
})
</script>
