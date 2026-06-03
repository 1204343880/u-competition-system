<template>
  <div class="hall-container">
    <!-- 左侧筛选栏 -->
    <div class="hall-sidebar">
      <!-- 学科分类 -->
      <div class="filter-section">
        <h4 class="filter-title">学科分类</h4>
        <div class="filter-items">
          <el-checkbox
            v-for="item in subjectGroups"
            :key="item.key"
            :model-value="activeSubjects.includes(item.key)"
            :disabled="loading"
            @change="(val) => toggleSubject(item.key, val)"
          >
            {{ item.label }}
          </el-checkbox>
        </div>
      </div>

      <!-- 竞赛级别 -->
      <div class="filter-section">
        <h4 class="filter-title">竞赛级别</h4>
        <div class="filter-items">
          <el-radio-group v-model="activeLevel" @change="handleLevelChange" :disabled="loading">
            <el-radio v-for="item in levelOptions" :key="item.value" :value="item.value" class="level-radio">
              {{ item.label }}
            </el-radio>
          </el-radio-group>
        </div>
      </div>

      <!-- 排序方式 -->
      <div class="filter-section">
        <h4 class="filter-title">排序方式</h4>
        <div class="filter-items">
          <el-radio-group v-model="activeSort" @change="handleQuery" :disabled="loading">
            <el-radio v-for="item in sortOptions" :key="item.value" :value="item.value" class="sort-radio">
              {{ item.label }}
            </el-radio>
          </el-radio-group>
        </div>
      </div>
    </div>

    <!-- 右侧列表 -->
    <div class="hall-main">
      <!-- 搜索栏 -->
      <el-form :model="queryParams" ref="queryRef" :inline="true" class="search-bar">
        <el-form-item prop="competitionName">
          <el-input
            v-model="queryParams.competitionName"
            placeholder="搜索竞赛名称"
            clearable
            style="width: 280px"
            @keyup.enter="handleQuery"
          >
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item prop="status">
          <el-select v-model="queryParams.status" placeholder="全部状态" clearable style="width: 130px" @change="handleQuery">
            <el-option v-for="dict in competition_status" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <!-- 结果概览 -->
      <div class="result-summary" v-if="!loading">
        <span>共 <strong>{{ total }}</strong> 个竞赛</span>
        <span v-if="activeSubjects.length" class="filter-tag">
          学科: {{ activeSubjects.map(k => subjectGroups.find(g => g.key === k)?.label).join('、') }}
        </span>
        <span v-if="activeLevel" class="filter-tag">
          级别: {{ levelOptions.find(l => l.value === activeLevel)?.label }}
        </span>
      </div>

      <!-- 竞赛表格 -->
      <el-table v-loading="loading" :data="competitionList">
        <el-table-column label="竞赛名称" min-width="280">
          <template #default="scope">
            <div class="comp-cell">
              <el-link type="primary" @click="handleDetail(scope.row)">{{ scope.row.competitionName }}</el-link>
              <div class="comp-desc" :title="stripHtml(scope.row.description)">
                {{ stripHtml(scope.row.description) }}
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="类别" width="90">
          <template #default="scope">
            <dict-tag :options="competition_category" :value="scope.row.category" />
          </template>
        </el-table-column>
        <el-table-column label="级别/赛制" width="95">
          <template #default="scope">
            <div class="badge-stack">
              <dict-tag :options="competition_level" :value="scope.row.competitionLevel" />
              <dict-tag :options="competition_type" :value="scope.row.competitionType" />
            </div>
          </template>
        </el-table-column>
        <el-table-column label="主办方" prop="organizer" width="140" :show-overflow-tooltip="true" />
        <el-table-column label="报名截止" width="100">
          <template #default="scope">
            <span>{{ parseTime(scope.row.applyEndTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="80">
          <template #default="scope">
            <dict-tag :options="competition_status" :value="scope.row.status" />
          </template>
        </el-table-column>
        <el-table-column label="浏览" width="70" sortable="custom" prop="viewCount">
          <template #default="scope">
            <span v-if="scope.row.viewCount > 10000">{{ (scope.row.viewCount / 10000).toFixed(1) }}万</span>
            <span v-else>{{ scope.row.viewCount }}</span>
          </template>
        </el-table-column>
        <el-table-column label="标签" min-width="140">
          <template #default="scope">
            <el-tag
              v-for="tag in parseTags(scope.row.tags)"
              :key="tag"
              size="small"
              :type="getTagType(tag)"
              style="margin-right: 4px; margin-bottom: 2px"
            >{{ tag }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="70" fixed="right">
          <template #default="scope">
            <el-button link type="primary" size="small" @click="handleDetail(scope.row)">详情</el-button>
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

    <!-- 详情弹窗 -->
    <el-dialog :title="currentCompetition.competitionName" v-model="detailOpen" width="800px" append-to-body>
      <div v-if="currentCompetition.competitionId" class="detail-body">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="竞赛名称" :span="2">{{ currentCompetition.competitionName }}</el-descriptions-item>
          <el-descriptions-item label="竞赛类别">
            <dict-tag :options="competition_category" :value="currentCompetition.category" />
          </el-descriptions-item>
          <el-descriptions-item label="竞赛级别">
            <dict-tag :options="competition_level" :value="currentCompetition.competitionLevel" />
          </el-descriptions-item>
          <el-descriptions-item label="赛制">
            <dict-tag :options="competition_type" :value="currentCompetition.competitionType" />
          </el-descriptions-item>
          <el-descriptions-item label="当前状态">
            <dict-tag :options="competition_status" :value="currentCompetition.status" />
          </el-descriptions-item>
          <el-descriptions-item label="主办方">{{ currentCompetition.organizer }}</el-descriptions-item>
          <el-descriptions-item label="承办方">{{ currentCompetition.host || '-' }}</el-descriptions-item>
          <el-descriptions-item label="报名开始">{{ parseTime(currentCompetition.applyStartTime) }}</el-descriptions-item>
          <el-descriptions-item label="报名截止">{{ parseTime(currentCompetition.applyEndTime) }}</el-descriptions-item>
          <el-descriptions-item label="比赛开始">{{ parseTime(currentCompetition.startTime) }}</el-descriptions-item>
          <el-descriptions-item label="比赛结束">{{ parseTime(currentCompetition.endTime) }}</el-descriptions-item>
          <el-descriptions-item label="已报名 / 上限">{{ currentCompetition.currentParticipants }} / {{ currentCompetition.maxParticipants }}</el-descriptions-item>
          <el-descriptions-item label="浏览量">{{ currentCompetition.viewCount }}</el-descriptions-item>
          <el-descriptions-item label="标签" :span="2">
            <el-tag v-for="tag in parseTags(currentCompetition.tags)" :key="tag" size="small" :type="getTagType(tag)" style="margin-right: 4px">{{ tag }}</el-tag>
            <span v-if="!parseTags(currentCompetition.tags).length">-</span>
          </el-descriptions-item>
          <el-descriptions-item label="竞赛详情" :span="2">
            <div class="rich-content" v-html="currentCompetition.description || '暂无详情'"></div>
          </el-descriptions-item>
        </el-descriptions>
      </div>
      <template #footer>
        <el-button type="primary" v-if="currentCompetition.status === '0'" @click="handleApply">我要报名</el-button>
        <el-button @click="detailOpen = false">关 闭</el-button>
      </template>
    </el-dialog>

    <!-- 报名确认弹窗 -->
    <el-dialog title="确认报名" v-model="applyOpen" width="480px" append-to-body>
      <el-form :model="applyForm" label-width="80px">
        <el-form-item label="竞赛名称">
          <span style="font-weight: 600">{{ currentCompetition.competitionName }}</span>
        </el-form-item>
        <el-form-item label="赛制">
          <dict-tag :options="competition_type" :value="currentCompetition.competitionType" />
        </el-form-item>
        <el-form-item label="报名用户">
          <span>{{ userStore.name }}</span>
        </el-form-item>
        <el-form-item label="用户昵称">
          <span>{{ userStore.nickName || userStore.name }}</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" :loading="applyLoading" @click="submitApply">确定提交</el-button>
        <el-button @click="applyOpen = false">取 消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { Search } from '@element-plus/icons-vue'
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()
const {
  competition_status,
  competition_category,
  competition_type,
  competition_level
} = useDict('competition_status', 'competition_category', 'competition_type', 'competition_level')

const competitionList = ref([])
const loading = ref(true)
const total = ref(0)
const detailOpen = ref(false)
const applyOpen = ref(false)
const applyLoading = ref(false)
const currentCompetition = ref({})

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    competitionName: undefined,
    status: undefined
  }
})
const { queryParams } = toRefs(data)

import { listCompetition, getCompetition, applyCompetition } from '@/api/competition/hall'

const subjectGroups = [
  { key: 'engineering', label: '工科', codes: ['03', '05'] },
  { key: 'liberal',    label: '文体', codes: ['04'] },
  { key: 'science',    label: '理科', codes: ['06'] },
  { key: 'business',   label: '商科', codes: ['02'] },
  { key: 'comprehensive', label: '综合', codes: ['01'] }
]

const levelOptions = [
  { value: '',     label: '不限' },
  { value: '1',    label: '校级' },
  { value: '2',    label: '市级' },
  { value: '3',    label: '省级' },
  { value: '4',    label: '国家级' },
  { value: '5',    label: '国际级' },
  { value: '99',   label: '其他' }
]

const sortOptions = [
  { value: '',      label: '默认' },
  { value: 'apply', label: '报名时间' },
  { value: 'start', label: '开赛时间' },
  { value: 'update',label: '最近更新' },
  { value: 'view',  label: '最多浏览' }
]

const activeSubjects = ref([])
const activeLevel = ref('')
const activeSort = ref('')

function toggleSubject(key, checked) {
  if (checked) {
    activeSubjects.value.push(key)
  } else {
    activeSubjects.value = activeSubjects.value.filter(k => k !== key)
  }
  handleQuery()
}

function handleLevelChange() {
  handleQuery()
}

function getList() {
  loading.value = true
  const params = {
    pageNum: queryParams.value.pageNum,
    pageSize: queryParams.value.pageSize,
    competitionName: queryParams.value.competitionName,
    status: queryParams.value.status,
    sortBy: activeSort.value || undefined,
    competitionLevel: activeLevel.value || undefined
  }
  if (activeSubjects.value.length) {
    params.categories = activeSubjects.value
      .flatMap(k => subjectGroups.find(g => g.key === k)?.codes || [])
      .join(',')
  }
  listCompetition(params).then(response => {
    competitionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  activeSubjects.value = []
  activeLevel.value = ''
  activeSort.value = ''
  handleQuery()
}

function handleDetail(row) {
  getCompetition(row.competitionId).then(response => {
    currentCompetition.value = response.data
    detailOpen.value = true
  })
}

function handleApply() {
  detailOpen.value = false
  nextTick(() => {
    applyOpen.value = true
  })
}

function submitApply() {
  applyLoading.value = true
  applyCompetition(currentCompetition.value.competitionId).then(() => {
    proxy.$modal.msgSuccess('报名成功')
    applyLoading.value = false
    applyOpen.value = false
    getList()
  }).catch(() => {
    applyLoading.value = false
  })
}

function parseTags(tags) {
  if (!tags) return []
  try {
    return JSON.parse(tags)
  } catch (e) {
    return []
  }
}

function stripHtml(html) {
  if (!html) return ''
  const text = html.replace(/<[^>]+>/g, '').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&')
  return text.length > 80 ? text.substring(0, 80) + '...' : text
}

const tagTypeMap = {
  'A类赛事': 'danger', 'B类赛事': 'warning', '国家级': 'danger', '国际级': 'danger',
  '保研加分': 'success', '综测加分': 'success', '综合测评加分': 'success', '立项支持': 'success',
  '双一流高校覆盖': 'warning', '挑战杯热身': 'warning', '国赛热身': 'warning',
  '数学建模': 'primary', '人工智能': 'primary', '客观题答题': 'info',
  '国家一级社团': '', '互联网+': ''
}

function getTagType(tag) {
  for (const [key, type] of Object.entries(tagTypeMap)) {
    if (tag.includes(key)) return type
  }
  return 'info'
}

getList()
</script>

<style scoped>
.hall-container {
  display: flex;
  gap: 16px;
  min-height: calc(100vh - 140px);
}

.hall-sidebar {
  width: 200px;
  flex-shrink: 0;
  background: #fff;
  border-radius: 4px;
  padding: 16px 12px;
  height: fit-content;
  position: sticky;
  top: 80px;
}

.hall-main {
  flex: 1;
  min-width: 0;
}

.filter-section {
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #ebeef5;
}
.filter-section:last-child {
  border-bottom: none;
  margin-bottom: 0;
}

.filter-title {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 8px 0;
}

.filter-items {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.filter-items :deep(.el-checkbox) {
  height: 28px;
  margin-right: 0;
}

.level-radio, .sort-radio {
  display: block;
  height: 28px;
  line-height: 28px;
  margin-right: 0;
}

.search-bar {
  margin-bottom: 0;
  padding: 0;
}
.search-bar :deep(.el-form-item) {
  margin-bottom: 8px;
  margin-right: 8px;
}

.result-summary {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 10px;
  font-size: 13px;
  color: #606266;
}
.result-summary strong {
  color: #409eff;
}
.filter-tag {
  display: inline-block;
  padding: 2px 8px;
  background: #ecf5ff;
  color: #409eff;
  border-radius: 3px;
  font-size: 12px;
}

.rich-content {
  max-height: 400px;
  overflow-y: auto;
  line-height: 1.8;
}
.rich-content :deep(p) {
  margin: 4px 0;
}
.rich-content :deep(strong) {
  color: #303133;
}

.comp-cell .comp-desc {
  font-size: 12px;
  color: #909399;
  line-height: 1.5;
  margin-top: 2px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.badge-stack {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

@media (max-width: 900px) {
  .hall-sidebar {
    display: none;
  }
}
</style>
