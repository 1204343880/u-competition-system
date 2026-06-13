<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="竞赛名称" prop="competitionName">
        <el-input v-model="queryParams.competitionName" placeholder="请输入竞赛名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="竞赛类别" prop="category">
        <el-select v-model="queryParams.category" placeholder="竞赛类别" clearable style="width: 160px">
          <el-option v-for="dict in competition_category" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="竞赛级别" prop="competitionLevel">
        <el-select v-model="queryParams.competitionLevel" placeholder="竞赛级别" clearable style="width: 160px">
          <el-option v-for="dict in competition_level" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="竞赛状态" clearable style="width: 160px">
          <el-option v-for="dict in competition_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:competition:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['system:competition:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:competition:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="竞赛名称" align="center" prop="competitionName" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="类别" align="center" prop="category" width="90">
        <template #default="scope">
          <dict-tag :options="competition_category" :value="scope.row.category" />
        </template>
      </el-table-column>
      <el-table-column label="级别" align="center" prop="competitionLevel" width="90">
        <template #default="scope">
          <dict-tag :options="competition_level" :value="scope.row.competitionLevel" />
        </template>
      </el-table-column>
      <el-table-column label="赛制" align="center" prop="competitionType" width="90">
        <template #default="scope">
          <dict-tag :options="competition_type" :value="scope.row.competitionType" />
        </template>
      </el-table-column>
      <el-table-column label="主办方" align="center" prop="organizer" width="140" :show-overflow-tooltip="true" />
      <el-table-column label="报名截止" align="center" prop="applyEndTime" width="110">
        <template #default="scope">
          <span>{{ parseTime(scope.row.applyEndTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="报名人数" align="center" width="100">
        <template #default="scope">
          <span>{{ scope.row.currentParticipants || 0 }} / {{ scope.row.maxParticipants || '不限' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template #default="scope">
          <dict-tag :options="competition_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="浏览" align="center" prop="viewCount" width="70" />
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:competition:edit']">编辑</el-button>
          <el-button link type="primary" icon="View" @click="handlePreview(scope.row)">预览</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:competition:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form ref="competitionRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="竞赛名称" prop="competitionName">
          <el-input v-model="form.competitionName" placeholder="请输入竞赛名称" />
        </el-form-item>
        <el-form-item label="竞赛状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
            <el-option v-for="dict in competition_status" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="竞赛类别" prop="category">
          <el-select v-model="form.category" placeholder="请选择类别" style="width: 100%">
            <el-option v-for="dict in competition_category" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="竞赛级别" prop="competitionLevel">
          <el-select v-model="form.competitionLevel" placeholder="请选择级别" style="width: 100%">
            <el-option v-for="dict in competition_level" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="赛制" prop="competitionType">
          <el-select v-model="form.competitionType" placeholder="请选择赛制" style="width: 100%">
            <el-option v-for="dict in competition_type" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="主办方" prop="organizer">
          <el-input v-model="form.organizer" placeholder="请输入主办方" />
        </el-form-item>
        <el-form-item label="承办方" prop="host">
          <el-input v-model="form.host" placeholder="请输入承办方" />
        </el-form-item>
        <el-form-item label="报名开始" prop="applyStartTime">
          <el-date-picker v-model="form.applyStartTime" type="datetime" placeholder="选择报名开始时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
        </el-form-item>
        <el-form-item label="报名截止" prop="applyEndTime">
          <el-date-picker v-model="form.applyEndTime" type="datetime" placeholder="选择报名截止时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
        </el-form-item>
        <el-form-item label="比赛开始" prop="startTime">
          <el-date-picker v-model="form.startTime" type="datetime" placeholder="选择比赛开始时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
        </el-form-item>
        <el-form-item label="比赛结束" prop="endTime">
          <el-date-picker v-model="form.endTime" type="datetime" placeholder="选择比赛结束时间" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
        </el-form-item>
        <el-form-item label="人数上限" prop="maxParticipants">
          <el-input-number v-model="form.maxParticipants" :min="0" placeholder="0表示不限" style="width: 100%" />
        </el-form-item>
        <el-form-item label="标签" prop="tags">
          <el-input v-model="form.tags" placeholder="请输入标签，逗号分隔" />
        </el-form-item>
        <el-form-item label="竞赛详情" prop="description">
          <Editor v-model="form.description" :height="300" />
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

<script setup name="Competition">
import Editor from '@/components/Editor/index.vue'
import { listCompetition, getCompetition, addCompetition, updateCompetition, delCompetition } from '@/api/competition/competition'

const { proxy } = getCurrentInstance()
const {
  competition_status,
  competition_category,
  competition_type,
  competition_level
} = useDict('competition_status', 'competition_category', 'competition_type', 'competition_level')

const competitionList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref('')

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    competitionName: undefined,
    category: undefined,
    competitionLevel: undefined,
    status: undefined
  },
  rules: {
    competitionName: [{ required: true, message: '竞赛名称不能为空', trigger: 'blur' }],
    category: [{ required: true, message: '竞赛类别不能为空', trigger: 'change' }],
    competitionLevel: [{ required: true, message: '竞赛级别不能为空', trigger: 'change' }],
    competitionType: [{ required: true, message: '赛制不能为空', trigger: 'change' }],
    organizer: [{ required: true, message: '主办方不能为空', trigger: 'blur' }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listCompetition(queryParams.value).then(response => {
    competitionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    competitionId: undefined,
    competitionName: undefined,
    status: '0',
    category: undefined,
    competitionLevel: undefined,
    competitionType: undefined,
    organizer: undefined,
    host: undefined,
    applyStartTime: undefined,
    applyEndTime: undefined,
    startTime: undefined,
    endTime: undefined,
    maxParticipants: 0,
    tags: undefined,
    description: undefined
  }
  proxy.resetForm('competitionRef')
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function handleAdd() {
  reset()
  open.value = true
  title.value = '添加竞赛'
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.competitionId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleUpdate(row) {
  reset()
  const competitionId = row.competitionId || ids.value
  getCompetition(competitionId).then(response => {
    form.value = response.data
    open.value = true
    title.value = '修改竞赛'
  })
}

function handlePreview(row) {
  window.open('/match/hall/' + row.competitionId, '_blank')
}

function submitForm() {
  proxy.$refs['competitionRef'].validate(valid => {
    if (valid) {
      if (form.value.tags && typeof form.value.tags === 'string') {
        form.value.tags = form.value.tags.split(',').map(t => t.trim()).filter(Boolean)
      }
      if (form.value.competitionId != undefined) {
        updateCompetition(form.value).then(response => {
          proxy.$modal.msgSuccess('修改成功')
          open.value = false
          getList()
        })
      } else {
        addCompetition(form.value).then(response => {
          proxy.$modal.msgSuccess('新增成功')
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  const competitionIds = row.competitionId || ids.value
  proxy.$modal.confirm('是否确认删除竞赛编号为"' + competitionIds + '"的数据项？').then(function() {
    return delCompetition(competitionIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

getList()
</script>
