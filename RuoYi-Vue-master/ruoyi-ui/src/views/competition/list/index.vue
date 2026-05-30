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
      <el-form-item label="竞赛类别" prop="category">
        <el-select v-model="queryParams.category" placeholder="请选择竞赛类别" clearable style="width: 160px">
          <el-option label="全部" value="" />
          <el-option label="学科竞赛" value="01" />
          <el-option label="创新创业" value="02" />
          <el-option label="技能竞赛" value="03" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['competition:list:add']">新增竞赛</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" :columns="columns" storageKey="competition-list"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="竞赛编号" align="center" prop="competitionId" v-if="columns.competitionId.visible" />
      <el-table-column label="竞赛名称" align="center" v-if="columns.competitionName.visible" :show-overflow-tooltip="true">
        <template #default="scope">
          <a class="link-type" style="cursor:pointer" @click="handleViewData(scope.row)">{{ scope.row.competitionName }}</a>
        </template>
      </el-table-column>
      <el-table-column label="竞赛类别" align="center" prop="categoryName" v-if="columns.categoryName.visible" />
      <el-table-column label="主办方" align="center" prop="organizer" v-if="columns.organizer.visible" />
      <el-table-column label="报名时间" align="center" v-if="columns.applyTime.visible" width="200">
        <template #default="scope">
          <span>{{ parseTime(scope.row.applyStartTime) }} - {{ parseTime(scope.row.applyEndTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="竞赛时间" align="center" v-if="columns.competitionTime.visible" width="200">
        <template #default="scope">
          <span>{{ parseTime(scope.row.startTime) }} - {{ parseTime(scope.row.endTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="参赛人数" align="center" v-if="columns.participants.visible">
        <template #default="scope">
          <span>{{ scope.row.currentParticipants }}/{{ scope.row.maxParticipants }}</span>
        </template>
      </el-table-column>
      <el-table-column label="竞赛状态" align="center" v-if="columns.status.visible">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : (scope.row.status === '1' ? 'warning' : 'info')">
            {{ scope.row.status === '0' ? '报名中' : (scope.row.status === '1' ? '进行中' : '已结束') }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-tooltip content="详情" placement="top">
            <el-button link type="primary" icon="Search" @click="handleViewData(scope.row)" v-hasPermi="['competition:list:query']"></el-button>
          </el-tooltip>
          <el-tooltip content="修改" placement="top">
            <el-button link type="primary" icon="Edit" @click="handleEdit(scope.row)" v-hasPermi="['competition:list:edit']"></el-button>
          </el-tooltip>
          <el-tooltip content="删除" placement="top">
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['competition:list:remove']"></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { listCompetition, getCompetition, deleteCompetition } from '@/api/competition/my'
import { parseTime } from '@/utils/ruoyi'
import Pagination from '@/components/Pagination'
import RightToolbar from '@/components/RightToolbar'

const router = useRouter()
const proxy = window.proxy

const loading = ref(true)
const total = ref(0)
const showSearch = ref(true)
const ids = ref([])
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  competitionName: '',
  status: '',
  category: ''
})
const columns = reactive({
  competitionId: { visible: true },
  competitionName: { visible: true },
  categoryName: { visible: true },
  organizer: { visible: true },
  applyTime: { visible: true },
  competitionTime: { visible: true },
  participants: { visible: true },
  status: { visible: true }
})

const competitionList = ref([])

/** 查询竞赛列表 */
function getList() {
  loading.value = true
  listCompetition(queryParams).then(response => {
    competitionList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  queryParams.competitionName = ''
  queryParams.status = ''
  queryParams.category = ''
  handleQuery()
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.competitionId)
}

/** 新增竞赛 */
function handleAdd() {
  router.push({ path: '/competition/list/add' })
}

/** 修改竞赛 */
function handleEdit(row) {
  router.push({ path: '/competition/list/edit', query: { competitionId: row.competitionId } })
}

/** 查看竞赛详情 */
function handleViewData(row) {
  router.push({ path: '/competition/list/detail', query: { competitionId: row.competitionId } })
}

/** 删除竞赛 */
function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除竞赛"' + row.competitionName + '"？').then(function () {
    return deleteCompetition(row.competitionId)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

onMounted(() => {
  getList()
})
</script>