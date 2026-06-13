<template>
  <div class="dashboard-container">
    <!-- 统计卡片 -->
    <el-row :gutter="16" class="stat-row">
      <el-col :xs="24" :sm="12" :md="6" v-for="card in statCards" :key="card.label">
        <div class="stat-card" :style="{ '--accent': card.color }">
          <div class="stat-left">
            <span class="stat-label">{{ card.label }}</span>
            <span class="stat-value">{{ card.value }}</span>
          </div>
          <div class="stat-icon">
            <el-icon :size="36" :color="card.color"><component :is="card.icon" /></el-icon>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 快捷操作 -->
    <el-row :gutter="16" class="quick-row">
      <el-col :xs="24" :sm="8" v-for="item in quickActions" :key="item.title">
        <div class="quick-card" @click="$router.push(item.path)">
          <el-icon :size="32" :color="item.color"><component :is="item.icon" /></el-icon>
          <div class="quick-info">
            <span class="quick-title">{{ item.title }}</span>
            <span class="quick-desc">{{ item.desc }}</span>
          </div>
          <el-icon class="quick-arrow" :size="18"><ArrowRight /></el-icon>
        </div>
      </el-col>
    </el-row>

    <!-- 待办事项 -->
    <el-card shadow="never" class="todo-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">待办事项</span>
          <el-button text type="primary" @click="fetchTodos">刷新</el-button>
        </div>
      </template>
      <el-table :data="todoList" v-loading="todoLoading" size="small" empty-text="暂无待办">
        <el-table-column label="类型" width="110" align="center">
          <template #default="scope">
            <el-tag :type="scope.row.type === '报名审核' ? 'warning' : 'info'" size="small">{{ scope.row.type }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="内容" prop="content" :show-overflow-tooltip="true" min-width="200" />
        <el-table-column label="提交时间" prop="time" width="170" align="center" />
        <el-table-column label="操作" width="100" align="center">
          <template #default="scope">
            <el-button link type="primary" size="small" @click="handleTodoAction(scope.row)">处理</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup name="Dashboard">
import { ref, onMounted } from 'vue'
import { Trophy, Medal, DocumentChecked, DataBoard, Plus, List, Setting, ArrowRight } from '@element-plus/icons-vue'
import { listCompetition } from '@/api/competition/competition'
import { listApplyAudit } from '@/api/competition/audit'
import { listResultAudit } from '@/api/competition/result'

const statCards = ref([
  { label: '竞赛总数', value: '--', icon: 'Trophy', color: '#1a73e8' },
  { label: '进行中竞赛', value: '--', icon: 'DataBoard', color: '#34a853' },
  { label: '待审核报名', value: '--', icon: 'DocumentChecked', color: '#fbbc04' },
  { label: '待审核成绩', value: '--', icon: 'Medal', color: '#ea4335' }
])

const quickActions = [
  { title: '发布竞赛', desc: '创建与管理竞赛项目', icon: 'Plus', color: '#1a73e8', path: '/system/competition/index' },
  { title: '报名审核', desc: '审核学生报名申请', icon: 'List', color: '#fbbc04', path: '/system/competitionaudit/apply' },
  { title: '成绩管理', desc: '录入与审核竞赛成绩', icon: 'Setting', color: '#34a853', path: '/system/competition/result' }
]

const todoLoading = ref(false)
const todoList = ref([])

function fetchStats() {
  Promise.all([
    listCompetition({ pageNum: 1, pageSize: 1 }),
    listCompetition({ pageNum: 1, pageSize: 1, status: '1' }),
    listApplyAudit({ pageNum: 1, pageSize: 1, auditStatus: '0' }),
    listResultAudit({ pageNum: 1, pageSize: 1, auditStatus: '0' })
  ]).then(([allRes, activeRes, applyRes, resultRes]) => {
    statCards.value[0].value = allRes.total ?? '--'
    statCards.value[1].value = activeRes.total ?? '--'
    statCards.value[2].value = applyRes.total ?? '--'
    statCards.value[3].value = resultRes.total ?? '--'
  }).catch(() => {})
}

function fetchTodos() {
  todoLoading.value = true
  Promise.all([
    listApplyAudit({ pageNum: 1, pageSize: 5, auditStatus: '0' }),
    listResultAudit({ pageNum: 1, pageSize: 5, auditStatus: '0' })
  ]).then(([applyRes, resultRes]) => {
    const todos = []
    ;(applyRes.rows || []).forEach(item => {
      todos.push({
        id: item.applyId,
        type: '报名审核',
        content: `${item.userName || ''} 报名 ${item.competitionName || ''}`,
        time: item.createTime || '',
        route: '/system/competitionaudit/apply'
      })
    })
    ;(resultRes.rows || []).forEach(item => {
      todos.push({
        id: item.resultId,
        type: '成绩审核',
        content: `${item.competitionName || ''} - ${item.awardLevel || ''} 成绩待审核`,
        time: item.createTime || '',
        route: '/system/competitionaudit/result'
      })
    })
    todoList.value = todos.slice(0, 10)
    todoLoading.value = false
  }).catch(() => { todoLoading.value = false })
}

function handleTodoAction(row) {
  if (row.route) {
    window.location.hash = '#' + row.route
  }
}

onMounted(() => {
  fetchStats()
  fetchTodos()
})
</script>

<style scoped lang="scss">
.dashboard-container {
  padding: 0;
}

.stat-row {
  margin-bottom: 16px;
}

.stat-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 24px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-left: 4px solid var(--accent);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  cursor: default;
  margin-bottom: 8px;
}

.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.stat-left {
  display: flex;
  flex-direction: column;
}

.stat-label {
  font-size: 13px;
  color: #909399;
  margin-bottom: 6px;
}

.stat-value {
  font-size: 30px;
  font-weight: 700;
  color: #303133;
}

.stat-icon {
  width: 52px;
  height: 52px;
  border-radius: 12px;
  background: rgba(var(--accent-r, 26, 115, 232), 0.08);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

/* 快捷操作 */
.quick-row {
  margin-bottom: 16px;
}

.quick-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 8px;
}

.quick-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.quick-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.quick-title {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 4px;
}

.quick-desc {
  font-size: 12px;
  color: #909399;
}

.quick-arrow {
  color: #c0c4cc;
  flex-shrink: 0;
}

/* 待办事项 */
.todo-card {
  border-radius: 12px;
  border: 1px solid #f0f0f0;
}

.todo-card :deep(.el-card__header) {
  border-bottom: 1px solid #f5f5f5;
  padding: 16px 20px;
}

.todo-card :deep(.el-card__body) {
  padding: 0;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  position: relative;
  padding-left: 14px;
}

.card-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 18px;
  background: #1a73e8;
  border-radius: 2px;
}
</style>
