<template>
  <div class="admin-dashboard">
    <header class="admin-hero">
      <div class="hero-copy">
        <span class="hero-date">{{ todayText }}</span>
        <h1>{{ greeting }}，{{ userName }}</h1>
        <p>{{ summaryText }}</p>
        <div class="hero-actions">
          <el-button type="primary" @click="go('/competition/applyaudit')">处理待审核</el-button>
          <el-button @click="go('/competition/index')">管理竞赛</el-button>
        </div>
      </div>

      <div class="hero-metrics" aria-label="管理概览">
        <div v-for="item in metrics" :key="item.label" class="metric-item">
          <strong>{{ dashboardLoading ? '—' : item.value }}</strong>
          <span>{{ item.label }}</span>
        </div>
      </div>
    </header>

    <div class="workspace-grid">
      <section class="dashboard-panel todo-panel">
        <div class="panel-heading">
          <div>
            <span class="panel-kicker">优先处理</span>
            <h2>待办队列</h2>
          </div>
          <button class="text-action" type="button" :disabled="dashboardLoading" @click="loadDashboard">
            <el-icon><Refresh /></el-icon> 刷新
          </button>
        </div>

        <div v-loading="dashboardLoading" class="todo-list">
          <button
            v-for="item in todoList"
            :key="`${item.type}-${item.id}`"
            class="todo-item"
            type="button"
            @click="handleTodoAction(item)"
          >
            <span class="todo-marker" :class="item.tone"><span></span></span>
            <span class="todo-content">
              <span class="todo-meta">
                <em>{{ item.type }}</em>
                <time>{{ formatTodoTime(item.time) }}</time>
              </span>
              <strong>{{ item.content }}</strong>
            </span>
            <span class="todo-action">去处理 <el-icon><ArrowRight /></el-icon></span>
          </button>

          <div v-if="!dashboardLoading && !todoList.length" class="empty-todo">
            <span class="empty-icon"><el-icon><Check /></el-icon></span>
            <div><strong>当前没有待审核事项</strong><p>新的报名或成绩提交后，会在这里优先提醒。</p></div>
          </div>
        </div>
      </section>

      <aside class="dashboard-panel action-panel">
        <div class="panel-heading simple">
          <div>
            <span class="panel-kicker">常用工具</span>
            <h2>快捷操作</h2>
          </div>
        </div>

        <div class="action-list">
          <button v-for="item in quickActions" :key="item.title" type="button" class="action-item" @click="go(item.path)">
            <span class="action-icon" :class="item.tone"><el-icon><component :is="item.icon" /></el-icon></span>
            <span class="action-copy"><strong>{{ item.title }}</strong><small>{{ item.desc }}</small></span>
            <el-icon class="action-arrow"><ArrowRight /></el-icon>
          </button>
        </div>

        <div class="review-summary">
          <div class="summary-title"><span>审核概况</span><strong>{{ pendingTotal }} 项待处理</strong></div>
          <div class="summary-row">
            <span>报名审核</span><strong>{{ pendingApply }}</strong>
            <i><b :style="{ width: reviewPercent(pendingApply) }"></b></i>
          </div>
          <div class="summary-row result">
            <span>成绩审核</span><strong>{{ pendingResult }}</strong>
            <i><b :style="{ width: reviewPercent(pendingResult) }"></b></i>
          </div>
        </div>
      </aside>
    </div>
  </div>
</template>

<script setup name="Dashboard">
import { computed, onMounted, ref } from 'vue'
import { ArrowRight, Check, DocumentChecked, Plus, Refresh, Setting } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import useUserStore from '@/store/modules/user'
import { listCompetition } from '@/api/competition/competition'
import { listApplyAudit, listResultAudit } from '@/api/competition/audit'

const router = useRouter()
const userStore = useUserStore()

const dashboardLoading = ref(true)
const totalCompetition = ref(0)
const activeCompetition = ref(0)
const pendingApply = ref(0)
const pendingResult = ref(0)
const todoList = ref([])

const userName = computed(() => userStore.nickName || userStore.name || '管理员')
const pendingTotal = computed(() => pendingApply.value + pendingResult.value)
const todayText = computed(() => new Intl.DateTimeFormat('zh-CN', {
  month: 'long', day: 'numeric', weekday: 'long'
}).format(new Date()))
const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 6) return '夜深了'
  if (hour < 11) return '早上好'
  if (hour < 14) return '中午好'
  if (hour < 18) return '下午好'
  return '晚上好'
})
const summaryText = computed(() => {
  if (dashboardLoading.value) return '正在整理竞赛运营与审核信息。'
  if (pendingTotal.value) return `当前有 ${pendingTotal.value} 项审核事项等待处理，建议优先完成积压任务。`
  if (activeCompetition.value) return `审核队列已经清空，当前有 ${activeCompetition.value} 项竞赛正在进行。`
  return '当前没有待处理事项，系统运行平稳。'
})
const metrics = computed(() => [
  { label: '竞赛总数', value: totalCompetition.value },
  { label: '进行中', value: activeCompetition.value },
  { label: '待审报名', value: pendingApply.value },
  { label: '待审成绩', value: pendingResult.value }
])

const quickActions = [
  { title: '发布竞赛', desc: '创建并维护竞赛项目', icon: Plus, tone: 'blue', path: '/competition/index' },
  { title: '报名审核', desc: '处理学生报名申请', icon: DocumentChecked, tone: 'amber', path: '/competition/applyaudit' },
  { title: '成绩管理', desc: '录入并审核竞赛成绩', icon: Setting, tone: 'green', path: '/competition/result' }
]

function normalizeStatus(value) {
  if (value && typeof value === 'object') return String(value.code ?? '')
  return String(value ?? '')
}

function buildTodos(applyRows, resultRows) {
  const todos = []
  applyRows.forEach(item => {
    todos.push({
      id: item.applyId,
      type: '报名审核',
      content: `${item.userName || '学生'} 报名 ${item.competitionName || '未命名竞赛'}`,
      time: item.createTime || '',
      tone: 'amber',
      route: '/competition/applyaudit'
    })
  })
  resultRows.forEach(item => {
    todos.push({
      id: item.resultId,
      type: '成绩审核',
      content: `${item.competitionName || '未命名竞赛'} · ${item.awardLevel || '成绩记录'}待审核`,
      time: item.createTime || '',
      tone: 'blue',
      route: '/competition/resultaudit'
    })
  })
  return todos
    .sort((a, b) => (new Date(b.time).getTime() || 0) - (new Date(a.time).getTime() || 0))
    .slice(0, 8)
}

async function loadDashboard() {
  dashboardLoading.value = true
  const [competitionRes, applyRes, resultRes] = await Promise.allSettled([
    listCompetition({ pageNum: 1, pageSize: 500 }),
    listApplyAudit({ pageNum: 1, pageSize: 8, auditStatus: '0' }),
    listResultAudit({ pageNum: 1, pageSize: 8, auditStatus: '0' })
  ])

  if (competitionRes.status === 'fulfilled') {
    const rows = competitionRes.value.rows || competitionRes.value.data || []
    totalCompetition.value = Number(competitionRes.value.total ?? rows.length)
    activeCompetition.value = rows.filter(item => normalizeStatus(item.status) === '1').length
  }

  const applyRows = applyRes.status === 'fulfilled' ? (applyRes.value.rows || applyRes.value.data || []) : []
  const resultRows = resultRes.status === 'fulfilled' ? (resultRes.value.rows || resultRes.value.data || []) : []
  pendingApply.value = applyRes.status === 'fulfilled' ? Number(applyRes.value.total ?? applyRows.length) : 0
  pendingResult.value = resultRes.status === 'fulfilled' ? Number(resultRes.value.total ?? resultRows.length) : 0
  todoList.value = buildTodos(applyRows, resultRows)
  dashboardLoading.value = false
}

function formatTodoTime(value) {
  if (!value) return '时间待确认'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  const today = new Date()
  if (date.toDateString() === today.toDateString()) {
    return new Intl.DateTimeFormat('zh-CN', { hour: '2-digit', minute: '2-digit', hour12: false }).format(date)
  }
  return `${date.getMonth() + 1}月${date.getDate()}日`
}

function reviewPercent(value) {
  if (!pendingTotal.value || !value) return '0%'
  return `${Math.max(8, Math.round(value / pendingTotal.value * 100))}%`
}

function go(path) {
  router.push(path)
}

function handleTodoAction(row) {
  if (row.route) router.push(row.route)
}

onMounted(loadDashboard)
</script>

<style scoped lang="scss">
.admin-dashboard {
  --admin-blue: #1a73e8;
  --admin-ink: #25272b;
  --admin-muted: #747982;
  max-width: 1320px;
  margin: 0 auto;
  padding: 22px 24px 40px;
  color: var(--admin-ink);
}

.admin-hero {
  min-height: 218px;
  display: grid;
  grid-template-columns: minmax(0, 1fr) 470px;
  align-items: center;
  gap: 56px;
  padding: 34px 42px;
  border-radius: 18px;
  background: linear-gradient(135deg, #f8fbff 0%, #eef4fc 100%);
}
.hero-date { display: block; margin-bottom: 10px; color: #6f8098; font-size: 12px; font-weight: 500; }
.hero-copy h1 { margin: 0; color: #26374f; font-size: clamp(27px, 3vw, 36px); font-weight: 650; letter-spacing: -.035em; }
.hero-copy p { margin: 11px 0 20px; color: #667183; font-size: 14px; }
.hero-actions { display: flex; gap: 8px; }
.hero-actions :deep(.el-button) { height: 38px; padding: 0 17px; border: 0; border-radius: 9px; }
.hero-actions :deep(.el-button:not(.el-button--primary)) { background: rgba(255,255,255,.78); box-shadow: 0 1px 2px rgba(40,47,59,.05); }

.hero-metrics { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); }
.metric-item { min-width: 0; display: flex; flex-direction: column; gap: 8px; padding: 4px 18px; border-left: 1px solid rgba(26,57,94,.09); }
.metric-item:first-child { padding-left: 0; border-left: 0; }
.metric-item strong { color: #26374f; font-size: 27px; font-weight: 650; line-height: 1; letter-spacing: -.04em; }
.metric-item span { color: #748197; font-size: 11px; white-space: nowrap; }

.workspace-grid { display: grid; grid-template-columns: minmax(0, 1.55fr) minmax(330px, .65fr); align-items: start; gap: 18px; margin-top: 18px; }
.dashboard-panel { padding: 24px; border-radius: 16px; background: #fff; box-shadow: inset 0 0 0 1px rgba(31,35,41,.035), 0 1px 2px rgba(41,45,52,.035); }
.panel-heading { display: flex; align-items: flex-end; justify-content: space-between; gap: 18px; margin-bottom: 16px; }
.panel-heading.simple { align-items: center; }
.panel-heading h2 { margin: 2px 0 0; font-size: 18px; font-weight: 650; letter-spacing: -.02em; }
.panel-kicker { color: #94989f; font-size: 11px; }
.text-action { display: inline-flex; align-items: center; gap: 5px; padding: 0; color: #777d85; border: 0; background: transparent; font-size: 12px; cursor: pointer; }
.text-action:hover { color: var(--admin-blue); }
.text-action:disabled { opacity: .45; cursor: default; }

.todo-list { min-height: 248px; }
.todo-item { width: 100%; display: flex; align-items: center; gap: 13px; padding: 15px 3px; text-align: left; border: 0; border-bottom: 1px solid rgba(31,35,41,.055); background: transparent; cursor: pointer; }
.todo-item:last-child { border-bottom: 0; }
.todo-marker { width: 32px; height: 32px; flex: none; display: grid; place-items: center; border-radius: 9px; background: #fff3df; }
.todo-marker span { width: 8px; height: 8px; border-radius: 50%; background: #d18420; }
.todo-marker.blue { background: #eaf2fe; }
.todo-marker.blue span { background: #1a73e8; }
.todo-content { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 5px; }
.todo-meta { display: flex; align-items: center; gap: 9px; color: #9a9ea5; font-size: 10px; }
.todo-meta em { color: #8d672c; font-style: normal; }
.todo-marker.blue + .todo-content .todo-meta em { color: #4f76a8; }
.todo-content strong { overflow: hidden; color: #3d4147; font-size: 13px; font-weight: 550; text-overflow: ellipsis; white-space: nowrap; }
.todo-item:hover .todo-content strong,.todo-item:hover .todo-action { color: var(--admin-blue); }
.todo-action { display: inline-flex; align-items: center; gap: 3px; color: #898e95; font-size: 12px; white-space: nowrap; }
.empty-todo { min-height: 230px; display: flex; align-items: center; justify-content: center; gap: 13px; color: #858a92; }
.empty-icon { width: 36px; height: 36px; display: grid; place-items: center; color: #25835c; border-radius: 10px; background: #e9f6ef; }
.empty-todo strong { color: #4a4f56; font-size: 14px; }.empty-todo p { margin: 5px 0 0; font-size: 12px; }

.action-list { display: flex; flex-direction: column; }
.action-item { width: 100%; position: relative; display: flex; align-items: center; gap: 12px; padding: 13px 2px; text-align: left; border: 0; border-bottom: 1px solid rgba(31,35,41,.055); background: transparent; cursor: pointer; }
.action-item:last-child { border-bottom: 0; }
.action-icon { width: 36px; height: 36px; flex: none; display: grid; place-items: center; color: #1a73e8; border-radius: 9px; background: #eaf2fe; font-size: 17px; }
.action-icon.amber { color: #b36a05; background: #fff3df; }.action-icon.green { color: #18865b; background: #e9f6ef; }
.action-copy { min-width: 0; flex: 1; display: flex; flex-direction: column; gap: 4px; }
.action-copy strong { color: #3d4147; font-size: 13px; font-weight: 600; }.action-copy small { color: #91959c; font-size: 11px; }
.action-arrow { color: #bdc0c5; }
.action-item:hover .action-copy strong,.action-item:hover .action-arrow { color: var(--admin-blue); }

.review-summary { margin-top: 18px; padding: 17px; border-radius: 12px; background: #f8f9fb; }
.summary-title { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; font-size: 12px; }
.summary-title span { color: #686e77; font-weight: 600; }.summary-title strong { color: #4d535b; font-size: 11px; font-weight: 500; }
.summary-row { display: grid; grid-template-columns: 1fr auto; gap: 7px 12px; margin-top: 12px; color: #858a92; font-size: 11px; }
.summary-row strong { color: #8d672c; font-size: 12px; }.summary-row i { grid-column: 1 / -1; height: 4px; overflow: hidden; border-radius: 4px; background: #e9ebee; }
.summary-row i b { display: block; height: 100%; border-radius: inherit; background: #d7a24b; transition: width 300ms ease; }
.summary-row.result strong { color: #4f76a8; }.summary-row.result i b { background: #6f9fe3; }

@media (max-width: 1080px) {
  .admin-hero { grid-template-columns: 1fr; gap: 28px; }
  .workspace-grid { grid-template-columns: 1fr; }
}
@media (max-width: 720px) {
  .admin-dashboard { padding: 16px 12px 28px; }
  .admin-hero { padding: 28px 22px; }
  .hero-metrics { grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 18px 0; }
  .metric-item:nth-child(3) { padding-left: 0; border-left: 0; }
  .dashboard-panel { padding: 20px 17px; }
  .todo-action { display: none; }
}
</style>
