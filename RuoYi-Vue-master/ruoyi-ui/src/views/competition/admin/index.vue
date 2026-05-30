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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['competition:admin:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['competition:admin:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['competition:admin:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" :columns="columns" storageKey="competition-admin"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="竞赛编号" align="center" prop="competitionId" v-if="columns.competitionId.visible" />
      <el-table-column label="竞赛名称" align="center" v-if="columns.competitionName.visible" :show-overflow-tooltip="true" />
      <el-table-column label="竞赛类别" align="center" prop="categoryName" v-if="columns.categoryName.visible" />
      <el-table-column label="报名开始" align="center" prop="registerStart" v-if="columns.registerStart.visible" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.registerStart) }}</span>
        </template>
      </el-table-column>
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
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['competition:admin:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['competition:admin:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="竞赛名称" prop="competitionName">
          <el-input v-model="form.competitionName" placeholder="请输入竞赛名称" />
        </el-form-item>
        <el-form-item label="竞赛类别" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择竞赛类别" style="width: 100%">
            <el-option label="学科竞赛" value="1" />
            <el-option label="创新实践" value="2" />
            <el-option label="综合竞赛" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="报名开始时间" prop="registerStart">
          <el-date-picker v-model="form.registerStart" type="datetime" placeholder="请选择报名开始时间" style="width: 100%" />
        </el-form-item>
        <el-form-item label="报名截止时间" prop="registerEnd">
          <el-date-picker v-model="form.registerEnd" type="datetime" placeholder="请选择报名截止时间" style="width: 100%" />
        </el-form-item>
        <el-form-item label="竞赛描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入竞赛描述" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { listCompetition, getCompetition, delCompetition, addCompetition, updateCompetition } from '@/api/competition/admin'
import { parseTime } from '@/utils/ruoyi'
import Pagination from '@/components/Pagination'
import RightToolbar from '@/components/RightToolbar'

const proxy = window.proxy
const loading = ref(true)
const total = ref(0)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const open = ref(false)
const title = ref('')
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
  registerStart: { visible: false },
  registerEnd: { visible: true },
  status: { visible: true }
})

const competitionList = ref([])
const form = reactive({
  competitionId: undefined,
  competitionName: '',
  categoryId: '',
  registerStart: '',
  registerEnd: '',
  description: ''
})
const rules = {
  competitionName: [{ required: true, message: '竞赛名称不能为空', trigger: 'blur' }],
  categoryId: [{ required: true, message: '竞赛类别不能为空', trigger: 'change' }],
  registerEnd: [{ required: true, message: '报名截止时间不能为空', trigger: 'change' }]
}

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

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.competitionId = undefined
  form.competitionName = ''
  form.categoryId = ''
  form.registerStart = ''
  form.registerEnd = ''
  form.description = ''
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
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = '新增竞赛'
}

function handleUpdate(row) {
  reset()
  getCompetition(row.competitionId || ids.value[0]).then(response => {
    Object.assign(form, response.data)
    open.value = true
    title.value = '修改竞赛'
  })
}

function handleDelete(row) {
  const competitionIds = row.competitionId || ids.value
  proxy.$modal.confirm('是否确认删除该竞赛？').then(() => {
    return delCompetition(competitionIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  })
}

function submitForm() {
  proxy.$refs.formRef.validate(valid => {
    if (valid) {
      if (form.competitionId !== undefined) {
        updateCompetition(form).then(() => {
          proxy.$modal.msgSuccess('修改成功')
          open.value = false
          getList()
        })
      } else {
        addCompetition(form).then(() => {
          proxy.$modal.msgSuccess('新增成功')
          open.value = false
          getList()
        })
      }
    }
  })
}

onMounted(() => {
  getList()
})
</script>
