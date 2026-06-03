<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-change="handleTabChange">
      <el-tab-pane label="往届项目复盘" name="retrospect">
        <el-form :model="retrospectQuery" :inline="true" class="search-form">
          <el-form-item label="项目名称">
            <el-input v-model="retrospectQuery.projectName" placeholder="请输入项目名称" clearable @keyup.enter="getList" />
          </el-form-item>
          <el-form-item label="竞赛名称">
            <el-input v-model="retrospectQuery.competitionName" placeholder="请输入竞赛名称" clearable @keyup.enter="getList" />
          </el-form-item>
          <el-form-item label="获奖级别">
            <el-select v-model="retrospectQuery.awardLevel" placeholder="请选择" clearable>
              <el-option label="国家级" value="国家级" />
              <el-option label="省级" value="省级" />
              <el-option label="市级" value="市级" />
              <el-option label="校级" value="校级" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="Search" @click="getList">搜索</el-button>
            <el-button icon="Refresh" @click="resetRetrospectQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row class="mb8" :gutter="10">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAddRetrospect">投稿复盘</el-button>
          </el-col>
        </el-row>
        <el-table v-loading="loading" :data="retrospectList">
          <el-table-column label="项目名称" align="center" prop="projectName" :show-overflow-tooltip="true" />
          <el-table-column label="竞赛名称" align="center" prop="competitionName" width="160" />
          <el-table-column label="获奖级别" align="center" prop="awardLevel" width="100">
            <template #default="scope">
              <el-tag :type="scope.row.awardLevel === '国家级' ? 'danger' : 'warning'">
                {{ scope.row.awardLevel }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="团队负责人" align="center" prop="leaderName" width="100" />
          <el-table-column label="年份" align="center" prop="year" width="80" />
          <el-table-column label="操作" align="center" width="180">
            <template #default="scope">
              <el-button link type="primary" icon="View" @click="handleViewRetrospect(scope.row)">查看</el-button>
              <el-button link type="primary" icon="Edit" @click="handleEditRetrospect(scope.row)">编辑</el-button>
              <el-button link type="danger" icon="Delete" @click="handleDeleteRetrospect(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <pagination
          v-show="retrospectTotal > 0"
          :total="retrospectTotal"
          v-model:page="retrospectQuery.pageNum"
          v-model:limit="retrospectQuery.pageSize"
          @pagination="getList"
        />
      </el-tab-pane>

      <el-tab-pane label="学长学姐经验帖" name="experience">
        <el-form :model="experienceQuery" :inline="true" class="search-form">
          <el-form-item label="标题">
            <el-input v-model="experienceQuery.title" placeholder="请输入标题" clearable @keyup.enter="getList" />
          </el-form-item>
          <el-form-item label="作者">
            <el-input v-model="experienceQuery.author" placeholder="请输入作者" clearable @keyup.enter="getList" />
          </el-form-item>
          <el-form-item label="分类">
            <el-select v-model="experienceQuery.category" placeholder="请选择" clearable>
              <el-option label="备赛心得" value="备赛心得" />
              <el-option label="团队协作" value="团队协作" />
              <el-option label="时间管理" value="时间管理" />
              <el-option label="答辩经验" value="答辩经验" />
              <el-option label="技术分享" value="技术分享" />
              <el-option label="避坑指南" value="避坑指南" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="Search" @click="getList">搜索</el-button>
            <el-button icon="Refresh" @click="resetExperienceQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row class="mb8" :gutter="10">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAddExperience">发布经验帖</el-button>
          </el-col>
        </el-row>
        <el-table v-loading="loading" :data="experienceList">
          <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
          <el-table-column label="作者" align="center" prop="author" width="100" />
          <el-table-column label="分类" align="center" prop="category" width="120">
            <template #default="scope">
              <el-tag size="small">{{ scope.row.category }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="发布时间" align="center" prop="createTime" width="180">
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="浏览" align="center" prop="viewCount" width="80" />
          <el-table-column label="操作" align="center" width="180">
            <template #default="scope">
              <el-button link type="primary" icon="View" @click="handleViewExperience(scope.row)">阅读</el-button>
              <el-button link type="primary" icon="Edit" @click="handleEditExperience(scope.row)">编辑</el-button>
              <el-button link type="danger" icon="Delete" @click="handleDeleteExperience(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <pagination
          v-show="experienceTotal > 0"
          :total="experienceTotal"
          v-model:page="experienceQuery.pageNum"
          v-model:limit="experienceQuery.pageSize"
          @pagination="getList"
        />
      </el-tab-pane>

      <el-tab-pane label="我的提交" name="mySubmissions">
        <el-table v-loading="myLoading" :data="mySubmissionList">
          <el-table-column label="类型" width="80" align="center">
            <template #default="scope">
              <el-tag :type="scope.row.experienceId ? 'success' : 'warning'" size="small">
                {{ scope.row.experienceId ? '经验帖' : '复盘' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="标题/项目名" align="center" min-width="160" :show-overflow-tooltip="true">
            <template #default="scope">
              {{ scope.row.title || scope.row.projectName }}
            </template>
          </el-table-column>
          <el-table-column label="审核状态" width="100" align="center">
            <template #default="scope">
              <el-tag v-if="scope.row.auditStatus === '0'" type="warning" size="small">待审核</el-tag>
              <el-tag v-else-if="scope.row.auditStatus === '1'" type="success" size="small">已通过</el-tag>
              <el-tag v-else-if="scope.row.auditStatus === '2'" type="danger" size="small">已驳回</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="驳回原因" min-width="200" align="center">
            <template #default="scope">
              <span v-if="scope.row.auditStatus === '2' && scope.row.rejectReason" style="color: #f56c6c; font-size: 12px">
                {{ scope.row.rejectReason }}
              </span>
              <span v-else style="color: #c0c4cc">-</span>
            </template>
          </el-table-column>
          <el-table-column label="提交时间" align="center" width="160">
            <template #default="scope">
              {{ parseTime(scope.row.createTime) }}
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="160">
            <template #default="scope">
              <el-button
                v-if="scope.row.auditStatus === '1'"
                link type="primary" icon="View" size="small"
                @click="handleViewMy(scope.row)"
              >查看</el-button>
              <el-button
                v-if="scope.row.auditStatus === '2'"
                link type="warning" icon="Edit" size="small"
                @click="handleReSubmit(scope.row)"
              >修改</el-button>
              <el-button
                link type="danger" icon="Delete" size="small"
                @click="handleDeleteMy(scope.row)"
              >删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <pagination
          v-show="myTotal > 0"
          :total="myTotal"
          v-model:page="myQuery.pageNum"
          v-model:limit="myQuery.pageSize"
          @pagination="loadMySubmissions"
        />
      </el-tab-pane>
    </el-tabs>

    <el-dialog :title="retrospectFormTitle" v-model="retrospectDialogVisible" width="800px" @close="resetRetrospectForm">
      <el-form ref="retrospectFormRef" :model="retrospectForm" :rules="retrospectRules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="项目名称" prop="projectName">
              <el-input v-model="retrospectForm.projectName" placeholder="请输入项目名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="竞赛名称" prop="competitionName">
              <el-input v-model="retrospectForm.competitionName" placeholder="请输入竞赛名称" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="获奖级别" prop="awardLevel">
              <el-select v-model="retrospectForm.awardLevel" placeholder="请选择">
                <el-option label="国家级" value="国家级" />
                <el-option label="省级" value="省级" />
                <el-option label="市级" value="市级" />
                <el-option label="校级" value="校级" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="团队负责人" prop="leaderName">
              <el-input v-model="retrospectForm.leaderName" placeholder="请输入负责人" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="年份" prop="year">
              <el-input v-model="retrospectForm.year" placeholder="如2025" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="复盘内容" prop="content">
          <Editor v-model="retrospectForm.content" :min-height="280" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="retrospectDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitRetrospect">确 定</el-button>
      </template>
    </el-dialog>

    <el-dialog :title="experienceFormTitle" v-model="experienceDialogVisible" width="800px" @close="resetExperienceForm">
      <el-form ref="experienceFormRef" :model="experienceForm" :rules="experienceRules" label-width="80px">
        <el-row :gutter="20">
          <el-col :span="16">
            <el-form-item label="标题" prop="title">
              <el-input v-model="experienceForm.title" placeholder="请输入标题" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="分类" prop="category">
              <el-select v-model="experienceForm.category" placeholder="请选择">
                <el-option label="备赛心得" value="备赛心得" />
                <el-option label="团队协作" value="团队协作" />
                <el-option label="时间管理" value="时间管理" />
                <el-option label="答辩经验" value="答辩经验" />
                <el-option label="技术分享" value="技术分享" />
                <el-option label="避坑指南" value="避坑指南" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="正文内容" prop="content">
          <Editor v-model="experienceForm.content" :min-height="280" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="experienceDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitExperience">确 定</el-button>
      </template>
    </el-dialog>

    <el-dialog title="项目复盘详情" v-model="retrospectDetailVisible" width="800px">
      <el-descriptions :column="2" border>
        <el-descriptions-item label="项目名称">{{ retrospectDetail.projectName }}</el-descriptions-item>
        <el-descriptions-item label="竞赛名称">{{ retrospectDetail.competitionName }}</el-descriptions-item>
        <el-descriptions-item label="获奖级别">
          <el-tag :type="retrospectDetail.awardLevel === '国家级' ? 'danger' : 'warning'">
            {{ retrospectDetail.awardLevel }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="团队负责人">{{ retrospectDetail.leaderName }}</el-descriptions-item>
        <el-descriptions-item label="年份">{{ retrospectDetail.year }}</el-descriptions-item>
        <el-descriptions-item label="投稿人">{{ retrospectDetail.createBy }}</el-descriptions-item>
      </el-descriptions>
      <div class="detail-content" v-html="retrospectDetail.content" style="margin-top:20px; padding:16px; background:#fafafa; border-radius:4px; min-height:100px;"></div>
    </el-dialog>

    <el-dialog title="经验帖详情" v-model="experienceDetailVisible" width="800px">
      <div class="detail-header">
        <h2>{{ experienceDetail.title }}</h2>
        <div class="detail-meta">
          <span>作者：{{ experienceDetail.author }}</span>
          <span>分类：<el-tag size="small">{{ experienceDetail.category }}</el-tag></span>
          <span>发布时间：{{ parseTime(experienceDetail.createTime) }}</span>
          <span>浏览：{{ experienceDetail.viewCount }}</span>
        </div>
      </div>
      <el-divider />
      <div class="detail-content" v-html="experienceDetail.content" style="padding:16px; background:#fafafa; border-radius:4px; min-height:100px;"></div>
    </el-dialog>
  </div>
</template>

<script setup>
import { listRetrospect, getRetrospect, addRetrospect, updateRetrospect, delRetrospect, listExperience, getExperience, addExperience, updateExperience, delExperience, listMyRetrospects, listMyExperiences, getRetrospectRaw, getExperienceRaw } from '@/api/competition/knowledge'
import Editor from '@/components/Editor/index.vue'

const { proxy } = getCurrentInstance()

const activeTab = ref('retrospect')
const loading = ref(false)

const retrospectList = ref([])
const retrospectTotal = ref(0)
const retrospectDialogVisible = ref(false)
const retrospectDetailVisible = ref(false)
const retrospectFormRef = ref(null)
const retrospectFormTitle = ref('')
const retrospectForm = ref({
  retrospectId: null,
  projectName: '',
  competitionName: '',
  awardLevel: '',
  leaderName: '',
  year: '',
  content: ''
})
const retrospectDetail = ref({})

const experienceList = ref([])
const experienceTotal = ref(0)
const experienceDialogVisible = ref(false)
const experienceDetailVisible = ref(false)
const experienceFormRef = ref(null)
const experienceFormTitle = ref('')
const experienceForm = ref({
  experienceId: null,
  title: '',
  category: '',
  content: ''
})
const experienceDetail = ref({})

const retrospectQuery = ref({ pageNum: 1, pageSize: 10, projectName: '', competitionName: '', awardLevel: '' })
const experienceQuery = ref({ pageNum: 1, pageSize: 10, title: '', author: '', category: '' })

const myLoading = ref(false)
const mySubmissionList = ref([])
const myTotal = ref(0)
const myQuery = ref({ pageNum: 1, pageSize: 10 })

const retrospectRules = {
  projectName: [{ required: true, message: '请输入项目名称', trigger: 'blur' }],
  competitionName: [{ required: true, message: '请输入竞赛名称', trigger: 'blur' }],
  content: [{ required: true, message: '请输入复盘内容', trigger: 'blur' }]
}
const experienceRules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入正文内容', trigger: 'blur' }]
}

function getList() {
  loading.value = true
  if (activeTab.value === 'retrospect') {
    listRetrospect(retrospectQuery.value).then(res => {
      retrospectList.value = res.rows
      retrospectTotal.value = res.total
      loading.value = false
    }).catch(() => { loading.value = false })
  } else if (activeTab.value === 'mySubmissions') {
    loadMySubmissions()
  } else {
    listExperience(experienceQuery.value).then(res => {
      experienceList.value = res.rows
      experienceTotal.value = res.total
      loading.value = false
    }).catch(() => { loading.value = false })
  }
}

function handleTabChange() {
  retrospectQuery.value.pageNum = 1
  experienceQuery.value.pageNum = 1
  getList()
}

function resetRetrospectQuery() {
  retrospectQuery.value = { pageNum: 1, pageSize: 10, projectName: '', competitionName: '', awardLevel: '' }
  getList()
}

function resetExperienceQuery() {
  experienceQuery.value = { pageNum: 1, pageSize: 10, title: '', author: '', category: '' }
  getList()
}

function handleAddRetrospect() {
  retrospectFormTitle.value = '投稿项目复盘'
  retrospectDialogVisible.value = true
}

function handleEditRetrospect(row) {
  retrospectFormTitle.value = '编辑项目复盘'
  retrospectForm.value = {
    retrospectId: row.retrospectId,
    projectName: row.projectName,
    competitionName: row.competitionName,
    awardLevel: row.awardLevel,
    leaderName: row.leaderName,
    year: row.year,
    content: row.content
  }
  retrospectDialogVisible.value = true
}

function submitRetrospect() {
  retrospectFormRef.value.validate(valid => {
    if (!valid) return
    const data = { ...retrospectForm.value }
    let p
    if (data.retrospectId) {
      p = updateRetrospect(data)
    } else {
      p = addRetrospect(data)
    }
    p.then(() => {
      proxy.$modal.msgSuccess(data.retrospectId ? '修改成功' : '投稿成功，请等待审核')
      retrospectDialogVisible.value = false
      getList()
    })
  })
}

function handleDeleteRetrospect(row) {
  proxy.$modal.confirm('确认删除该复盘记录？').then(() => {
    return delRetrospect(row.retrospectId)
  }).then(() => {
    proxy.$modal.msgSuccess('删除成功')
    getList()
  })
}

function handleViewRetrospect(row) {
  getRetrospect(row.retrospectId).then(res => {
    retrospectDetail.value = res.data
    retrospectDetailVisible.value = true
  })
}

function resetRetrospectForm() {
  retrospectForm.value = {
    retrospectId: null,
    projectName: '',
    competitionName: '',
    awardLevel: '',
    leaderName: '',
    year: '',
    content: ''
  }
  retrospectFormRef.value && retrospectFormRef.value.resetFields()
}

function handleAddExperience() {
  experienceFormTitle.value = '发布经验帖'
  experienceDialogVisible.value = true
}

function handleEditExperience(row) {
  experienceFormTitle.value = '编辑经验帖'
  experienceForm.value = {
    experienceId: row.experienceId,
    title: row.title,
    category: row.category,
    content: row.content
  }
  experienceDialogVisible.value = true
}

function submitExperience() {
  experienceFormRef.value.validate(valid => {
    if (!valid) return
    const data = { ...experienceForm.value }
    let p
    if (data.experienceId) {
      p = updateExperience(data)
    } else {
      p = addExperience(data)
    }
    p.then(() => {
      proxy.$modal.msgSuccess(data.experienceId ? '修改成功' : '发布成功，请等待审核')
      experienceDialogVisible.value = false
      getList()
    })
  })
}

function handleDeleteExperience(row) {
  proxy.$modal.confirm('确认删除该经验帖？').then(() => {
    return delExperience(row.experienceId)
  }).then(() => {
    proxy.$modal.msgSuccess('删除成功')
    getList()
  })
}

function handleViewExperience(row) {
  getExperience(row.experienceId).then(res => {
    experienceDetail.value = res.data
    experienceDetailVisible.value = true
  })
}

function resetExperienceForm() {
  experienceForm.value = {
    experienceId: null,
    title: '',
    category: '',
    content: ''
  }
  experienceFormRef.value && experienceFormRef.value.resetFields()
}

function loadMySubmissions() {
  myLoading.value = true
  Promise.all([
    listMyRetrospects({ ...myQuery.value }),
    listMyExperiences({ ...myQuery.value })
  ]).then(([retroRes, expRes]) => {
    const retroData = retroRes.data || retroRes
    const expData = expRes.data || expRes
    const retros = ((retroData.rows || []).map(r => ({ ...r, _type: 'retrospect' })))
    const exps = ((expData.rows || []).map(e => ({ ...e, _type: 'experience' })))
    const merged = [...retros, ...exps].sort((a, b) => {
      const ta = a.createTime ? new Date(a.createTime).getTime() : 0
      const tb = b.createTime ? new Date(b.createTime).getTime() : 0
      return tb - ta
    })
    mySubmissionList.value = merged
    myTotal.value = retroData.total + expData.total
    myLoading.value = false
  }).catch(() => { myLoading.value = false })
}

function handleViewMy(row) {
  if (row._type === 'retrospect' || row.retrospectId) {
    getRetrospectRaw(row.retrospectId).then(res => {
      retrospectDetail.value = res.data
      retrospectDetailVisible.value = true
    })
  } else {
    getExperienceRaw(row.experienceId).then(res => {
      experienceDetail.value = res.data
      experienceDetailVisible.value = true
    })
  }
}

function handleReSubmit(row) {
  if (row._type === 'retrospect' || row.retrospectId) {
    retrospectFormTitle.value = '修改项目复盘（重新提交）'
    getRetrospectRaw(row.retrospectId).then(res => {
      const r = res.data
      if (r.auditStatus === '2') {
        proxy.$modal.alert('驳回原因："' + (r.rejectReason || '未填写') + '"，请修改后重新提交', '审核被驳回', { type: 'warning' })
      }
      retrospectForm.value = {
        retrospectId: r.retrospectId,
        projectName: r.projectName,
        competitionName: r.competitionName,
        awardLevel: r.awardLevel,
        leaderName: r.leaderName,
        year: r.year,
        content: r.content
      }
      retrospectDialogVisible.value = true
    })
  } else {
    experienceFormTitle.value = '修改经验帖（重新提交）'
    getExperienceRaw(row.experienceId).then(res => {
      const e = res.data
      if (e.auditStatus === '2') {
        proxy.$modal.alert('驳回原因："' + (e.rejectReason || '未填写') + '"，请修改后重新提交', '审核被驳回', { type: 'warning' })
      }
      experienceForm.value = {
        experienceId: e.experienceId,
        title: e.title,
        category: e.category,
        content: e.content
      }
      experienceDialogVisible.value = true
    })
  }
}

function handleDeleteMy(row) {
  const name = row.title || row.projectName || '该记录'
  proxy.$modal.confirm('确认删除"' + name + '"？').then(() => {
    if (row._type === 'retrospect' || row.retrospectId) {
      return delRetrospect(row.retrospectId)
    } else {
      return delExperience(row.experienceId)
    }
  }).then(() => {
    proxy.$modal.msgSuccess('删除成功')
    loadMySubmissions()
  })
}

getList()
</script>

<style scoped>
.search-form { margin-bottom: 10px; }
.search-form .el-form-item { margin-bottom: 10px; }
.mb8 { margin-bottom: 8px; }
.detail-header h2 { margin: 0 0 12px 0; font-size: 20px; }
.detail-meta { display: flex; gap: 20px; font-size: 13px; color: #909399; align-items: center; }
</style>
