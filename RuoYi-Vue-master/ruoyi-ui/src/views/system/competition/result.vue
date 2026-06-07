<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="竞赛名称" prop="competitionName">
        <el-input v-model="queryParams.competitionName" placeholder="请输入竞赛名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="获奖级别" prop="awardLevel">
        <el-select v-model="queryParams.awardLevel" placeholder="请选择获奖级别" clearable>
          <el-option label="国家级特等奖" value="国家级特等奖" />
          <el-option label="国家级一等奖" value="国家级一等奖" />
          <el-option label="国家级二等奖" value="国家级二等奖" />
          <el-option label="国家级三等奖" value="国家级三等奖" />
          <el-option label="省赛一等奖" value="省赛一等奖" />
          <el-option label="省赛二等奖" value="省赛二等奖" />
          <el-option label="省赛三等奖" value="省赛三等奖" />
          <el-option label="市赛" value="市赛" />
          <el-option label="校赛" value="校赛" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="待审核" value="0" />
          <el-option label="已确认" value="1" />
          <el-option label="已作废" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:competition:manage']">新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="list" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="参赛项目" align="center" prop="projectName" :show-overflow-tooltip="true" min-width="160" />
      <el-table-column label="所属竞赛" align="center" prop="competitionName" :show-overflow-tooltip="true" min-width="160" />
      <el-table-column label="获奖级别" align="center" prop="awardLevel" width="130">
        <template #default="scope">
          <el-tag v-if="scope.row.awardLevel" type="warning" size="small">{{ scope.row.awardLevel }}</el-tag>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="分数" align="center" prop="score" width="80" />
      <el-table-column label="排名" align="center" prop="ranking" width="80" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="warning" size="small">待审核</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="success" size="small">已确认</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="danger" size="small">已作废</el-tag>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:competition:manage']">编辑</el-button>
          <el-button v-if="scope.row.status !== '1'" link type="success" icon="Select" @click="handleConfirm(scope.row)">确认</el-button>
          <el-button v-if="scope.row.status === '1'" link type="warning" icon="Close" @click="handleCancel(scope.row)">作废</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:competition:manage']">删除</el-button>
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

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="600px" append-to-body destroy-on-close>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="所属竞赛" prop="competitionId">
          <el-select v-model="form.competitionId" placeholder="请选择竞赛" filterable clearable style="width: 100%">
            <el-option v-for="c in competitionOptions" :key="c.competitionId" :label="c.competitionName" :value="c.competitionId" />
          </el-select>
        </el-form-item>
        <el-form-item label="参赛项目" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入参赛项目名称" maxlength="100" />
        </el-form-item>
        <el-form-item label="获奖级别" prop="awardLevel">
          <el-select v-model="form.awardLevel" placeholder="请选择获奖级别" clearable style="width: 100%">
            <el-option label="国家级特等奖" value="国家级特等奖" />
            <el-option label="国家级一等奖" value="国家级一等奖" />
            <el-option label="国家级二等奖" value="国家级二等奖" />
            <el-option label="国家级三等奖" value="国家级三等奖" />
            <el-option label="省赛一等奖" value="省赛一等奖" />
            <el-option label="省赛二等奖" value="省赛二等奖" />
            <el-option label="省赛三等奖" value="省赛三等奖" />
            <el-option label="市赛" value="市赛" />
            <el-option label="校赛" value="校赛" />
          </el-select>
        </el-form-item>
        <el-form-item label="分数" prop="score">
          <el-input-number v-model="form.score" :min="0" :max="100" :precision="1" placeholder="0-100" style="width: 100%" />
        </el-form-item>
        <el-form-item label="排名" prop="ranking">
          <el-input-number v-model="form.ranking" :min="1" placeholder="请输入排名" controls-position="right" style="width: 100%" />
        </el-form-item>
        <el-form-item label="证书链接" prop="certificateUrl">
          <el-input v-model="form.certificateUrl" placeholder="请输入证书图片/文件链接" maxlength="500" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注信息" :rows="3" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm" :loading="submitLoading">确 定</el-button>
          <el-button @click="dialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="CompetitionResult">
import { listResult, getResult, addResult, updateResult, delResult, auditResult } from '@/api/competition/result'
import { listCompetition } from '@/api/competition/competition'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const submitLoading = ref(false)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const list = ref([])
const competitionOptions = ref([])

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  competitionName: '',
  awardLevel: '',
  status: ''
})

const dialog = reactive({
  visible: false,
  title: ''
})

const form = ref({})
const rules = {
  competitionId: [{ required: true, message: '请选择竞赛', trigger: 'change' }],
  projectName: [{ required: true, message: '请输入参赛项目名称', trigger: 'blur' }],
  awardLevel: [{ required: true, message: '请选择获奖级别', trigger: 'change' }]
}

function getList() {
  loading.value = true
  listResult(queryParams.value).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => { loading.value = false })
}

function getCompetitionOptions() {
  listCompetition({ pageNum: 1, pageSize: 999 }).then(res => {
    competitionOptions.value = res.rows || []
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.resultId)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleAdd() {
  dialog.title = '添加成绩'
  dialog.visible = true
  getCompetitionOptions()
  form.value = { competitionId: null, projectName: '', awardLevel: '', score: null, ranking: null, certificateUrl: '', remark: '' }
}

function handleUpdate(row) {
  dialog.title = '修改成绩'
  dialog.visible = true
  getCompetitionOptions()
  getResult(row.resultId).then(res => {
    form.value = res.data
  })
}

function submitForm() {
  proxy.$refs.formRef.validate(valid => {
    if (valid) {
      submitLoading.value = true
      const api = form.value.resultId ? updateResult : addResult
      api(form.value).then(() => {
        proxy.$modal.msgSuccess('操作成功')
        dialog.visible = false
        getList()
      }).finally(() => { submitLoading.value = false })
    }
  })
}

function handleConfirm(row) {
  proxy.$modal.confirm('确认该成绩记录？').then(() => {
    return auditResult({ resultId: row.resultId, status: '1' })
  }).then(() => {
    proxy.$modal.msgSuccess('成绩已确认')
    getList()
  })
}

function handleCancel(row) {
  proxy.$modal.confirm('确认作废该成绩记录？').then(() => {
    return auditResult({ resultId: row.resultId, status: '2' })
  }).then(() => {
    proxy.$modal.msgSuccess('成绩已作废')
    getList()
  })
}

function handleDelete(row) {
  const resultIds = row.resultId || ids.value.join(',')
  proxy.$modal.confirm(`确定删除该成绩记录？`).then(() => {
    return delResult(resultIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  })
}

getList()
</script>
