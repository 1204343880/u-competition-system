<template>
  <Dashboard v-if="isAdmin" />

  <div v-else class="student-home">
    <header class="welcome-panel">
      <div class="welcome-copy">
        <span class="eyebrow">{{ todayText }}</span>
        <h1>{{ greeting }}，{{ userName }}</h1>
        <p>{{ welcomeSummary }}</p>
        <div class="welcome-actions">
          <el-button type="primary" @click="go('/hall/list')">浏览竞赛</el-button>
          <el-button @click="go('/myrace/race')">我的赛程</el-button>
        </div>
      </div>
      <div class="hero-stats" aria-label="我的竞赛概览">
        <div v-for="stat in statsData" :key="stat.label" class="hero-stat">
          <span>{{ stat.label }}</span>
          <strong>{{ loading ? '—' : stat.value }}</strong>
        </div>
      </div>
    </header>

    <div class="primary-grid">
        <section class="home-panel task-panel">
          <div class="section-heading">
            <div>
              <span class="section-kicker">接下来</span>
              <h2>我的待办</h2>
            </div>
            <button class="text-action" type="button" @click="go('/myrace/race')">
              查看赛程 <el-icon><ArrowRight /></el-icon>
            </button>
          </div>

          <div v-if="tasks.length" class="task-list">
            <button
              v-for="task in tasks"
              :key="task.key"
              type="button"
              class="task-item"
              @click="openCompetition(task.competitionId)"
            >
              <span class="task-state" :class="task.tone"><span></span></span>
              <span class="task-content">
                <strong>{{ task.title }}</strong>
                <small>{{ task.description }}</small>
              </span>
              <span class="task-action">{{ task.action }} <el-icon><ArrowRight /></el-icon></span>
            </button>
          </div>

          <div v-else class="empty-note">
            <span class="empty-icon"><el-icon><Check /></el-icon></span>
            <div><strong>暂时没有待处理事项</strong><p>去竞赛大厅看看最近有哪些新机会。</p></div>
            <el-button text type="primary" @click="go('/hall/list')">发现竞赛</el-button>
          </div>
        </section>

        <section class="home-panel recommend-panel">
          <div class="section-heading">
            <div>
              <span class="section-kicker">为你推荐</span>
              <h2>近期竞赛</h2>
            </div>
            <button class="text-action" type="button" @click="go('/hall/list')">
              查看全部 <el-icon><ArrowRight /></el-icon>
            </button>
          </div>

          <div v-if="recommended.length" class="recommend-list">
            <button
              v-for="(item, index) in recommended"
              :key="item.competitionId"
              type="button"
              class="recommend-item"
              @click="openCompetition(item.competitionId)"
            >
              <span class="recommend-cover" :class="`cover-${index % 3}`">
                <img v-if="item.coverImage" :src="item.coverImage" :alt="`${item.competitionName}封面`" loading="lazy" />
                <el-icon v-else><Trophy /></el-icon>
              </span>
              <span class="recommend-copy">
                <strong>{{ item.competitionName }}</strong>
                <small>{{ item.organizer || '主办方待公布' }}</small>
                <span class="recommend-meta">
                  <em>{{ levelLabel(item.competitionLevel) }}</em>
                  <span>{{ deadlineText(item.applyEndTime) }}</span>
                </span>
              </span>
              <el-icon class="recommend-arrow"><ArrowRight /></el-icon>
            </button>
          </div>
          <div v-else class="empty-note compact">暂无可推荐竞赛</div>
        </section>
    </div>

    <section class="home-panel quick-panel">
      <div class="section-heading simple"><h2>快捷入口</h2></div>
      <div class="quick-list">
        <button v-for="item in quickActions" :key="item.title" type="button" class="quick-item" @click="go(item.path)">
          <span class="quick-icon" :style="{ color: item.color, background: item.background }">
            <el-icon><component :is="item.icon" /></el-icon>
          </span>
          <span><strong>{{ item.title }}</strong><small>{{ item.description }}</small></span>
          <el-icon class="quick-arrow"><ArrowRight /></el-icon>
        </button>
      </div>
    </section>

    <div class="bottom-grid">
        <section class="home-panel notice-panel">
          <div class="section-heading simple">
            <h2>通知与提醒</h2>
            <span v-if="unreadCount" class="unread-count">{{ unreadCount }} 条未读</span>
          </div>
          <div v-if="notices.length" class="notice-list">
            <article v-for="(notice, index) in notices" :key="notice.noticeId || index" class="notice-item">
              <span class="notice-dot" :class="`dot-${index % 3}`"></span>
              <div><strong>{{ notice.noticeTitle || notice.title }}</strong><time>{{ noticeTime(notice.createTime || notice.time) }}</time></div>
            </article>
          </div>
          <div v-else class="empty-note compact">暂无新通知</div>
        </section>

        <section class="home-panel platform-panel">
          <div class="section-heading simple"><h2>平台信息</h2></div>
          <div class="platform-grid">
            <div v-for="item in platformInfo" :key="item.label" class="platform-item">
              <span>{{ item.label }}</span>
              <strong :class="{ healthy: item.healthy }">{{ item.value }}</strong>
            </div>
          </div>
        </section>
    </div>
  </div>
</template>

<script setup name="Index">
import { computed, onMounted, ref } from 'vue'
import {
  ArrowRight, Bell, Check, Clock, Collection, Document,
  Edit, Trophy, User
} from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import useUserStore from '@/store/modules/user'
import Dashboard from '@/views/dashboard/index.vue'
import { listCompetition, listMyApplies } from '@/api/competition/hall'
import { getMyTeams } from '@/api/competition/team'
import { getMyResults } from '@/api/competition/result'
import { listNoticeTop } from '@/api/system/notice'

const router = useRouter()
const userStore = useUserStore()
const loading = ref(true)
const myEntries = ref([])
const recommended = ref([])
const competitionTotal = ref(0)
const resultCount = ref(0)
const notices = ref([])

const isAdmin = computed(() => {
  const roles = userStore.roles || []
  return roles.includes('admin') || roles.includes('ROLE_ADMIN')
})
const userName = computed(() => userStore.nickName || userStore.name || '同学')
const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 6) return '夜深了'
  if (hour < 11) return '早上好'
  if (hour < 14) return '中午好'
  if (hour < 18) return '下午好'
  return '晚上好'
})
const todayText = computed(() => new Intl.DateTimeFormat('zh-CN', {
  month: 'long', day: 'numeric', weekday: 'long'
}).format(new Date()))

const ongoingCount = computed(() => myEntries.value.filter(item => String(item.compStatus ?? item.status) === '1').length)
const pendingCount = computed(() => myEntries.value.filter(item => {
  const compStatus = String(item.compStatus ?? item.status ?? '')
  const auditStatus = String(item.auditStatus ?? item.teamStatus ?? '')
  return compStatus === '0' && (auditStatus === '0' || auditStatus === '')
}).length)
const welcomeSummary = computed(() => {
  if (!myEntries.value.length) return '从一场感兴趣的比赛开始，建立属于你的竞赛旅程。'
  if (pendingCount.value) return `你有 ${pendingCount.value} 项事项需要继续处理，别错过重要节点。`
  if (ongoingCount.value) return `你有 ${ongoingCount.value} 项比赛正在进行，保持节奏。`
  return '你的竞赛安排都在轨道上，去看看最近的新机会吧。'
})

const statsData = computed(() => [
  { label: '已参与', value: myEntries.value.length, icon: Trophy, color: '#1a73e8', background: '#eaf2fe' },
  { label: '进行中', value: ongoingCount.value, icon: Clock, color: '#18865b', background: '#e9f6ef' },
  { label: '待处理', value: pendingCount.value, icon: Edit, color: '#b06000', background: '#fff3df' },
  { label: '获奖与成果', value: resultCount.value, icon: Check, color: '#8354b3', background: '#f3ecfa' }
])

const tasks = computed(() => myEntries.value.slice(0, 4).map((item, index) => {
  const compStatus = String(item.compStatus ?? item.status ?? '')
  const auditStatus = String(item.auditStatus ?? item.teamStatus ?? '')
  let description = '查看竞赛进度与下一步安排'
  let action = '查看进度'
  let tone = 'blue'
  if (compStatus === '0' && auditStatus === '0') {
    description = item.entryType === 'team' ? '队伍尚未完成确认，请及时检查成员信息' : '报名信息正在等待审核'
    action = item.entryType === 'team' ? '完善队伍' : '查看报名'
    tone = 'amber'
  } else if (compStatus === '1') {
    description = '比赛正在进行，请留意材料提交与赛程通知'
    action = '继续参赛'
    tone = 'green'
  } else if (compStatus === '2') {
    description = '比赛已经结束，可以查看成绩与成果记录'
    action = '查看结果'
    tone = 'violet'
  }
  return {
    key: `${item.competitionId}-${item.entryType || index}`,
    competitionId: item.competitionId,
    title: item.competitionName || '未命名竞赛',
    description, action, tone
  }
}))

const quickActions = [
  { title: '竞赛大厅', description: '发现并报名感兴趣的比赛', icon: Collection, color: '#1a73e8', background: '#eaf2fe', path: '/hall/list' },
  { title: '组队匹配', description: '寻找队友，补齐团队能力', icon: User, color: '#18865b', background: '#e9f6ef', path: '/match/index' },
  { title: '薪火相传', description: '阅读学长学姐的参赛经验', icon: Document, color: '#b06000', background: '#fff3df', path: '/knowledge/index' },
  { title: '我的赛程', description: '管理报名、队伍与比赛进度', icon: Edit, color: '#8354b3', background: '#f3ecfa', path: '/myrace/race' }
]

const unreadCount = computed(() => notices.value.filter(item => item.isRead === false || item.readFlag === '0').length)
const platformInfo = computed(() => {
  const now = new Date()
  const startYear = now.getMonth() >= 8 ? now.getFullYear() : now.getFullYear() - 1
  return [
    { label: '当前学年', value: `${startYear}—${startYear + 1}` },
    { label: '开放竞赛', value: `${competitionTotal.value} 项` },
    { label: '当前身份', value: '参赛学生' },
    { label: '服务状态', value: '运行正常', healthy: true }
  ]
})

function go(path) { router.push(path) }
function openCompetition(id) {
  if (id == null) return
  router.push({ name: 'CompetitionDetail', params: { competitionId: id } })
}
function levelLabel(level) {
  return ({ '1': '校级', '2': '市级', '3': '省级', '4': '国家级', '5': '国际级' })[String(level)] || '竞赛'
}
function deadlineText(value) {
  if (!value) return '时间待公布'
  const deadline = new Date(value)
  const days = Math.ceil((deadline.getTime() - Date.now()) / 86400000)
  if (days < 0) return '报名已截止'
  if (days === 0) return '今天截止'
  if (days <= 7) return `${days} 天后截止`
  return `${deadline.getMonth() + 1}月${deadline.getDate()}日截止`
}
function noticeTime(value) {
  if (!value) return '最近'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return String(value)
  const diff = Math.floor((Date.now() - date.getTime()) / 86400000)
  if (diff <= 0) return '今天'
  if (diff === 1) return '昨天'
  if (diff < 7) return `${diff} 天前`
  return `${date.getMonth() + 1}月${date.getDate()}日`
}

function normalizeEntries(applyData, teamData) {
  const applies = (applyData || []).map(item => ({ ...item, entryType: 'individual' }))
  const teams = (teamData || []).map(item => ({
    ...item,
    entryType: 'team',
    compStatus: item.compStatus,
    teamStatus: item.status
  }))
  const merged = [...applies, ...teams]
  const seen = new Set()
  return merged.filter(item => {
    const key = `${item.competitionId}-${item.entryType}-${item.teamId || ''}`
    if (seen.has(key)) return false
    seen.add(key)
    return true
  })
}

onMounted(async () => {
  if (isAdmin.value) return
  const [applyRes, teamRes, competitionRes, resultRes, noticeRes] = await Promise.allSettled([
    listMyApplies(),
    getMyTeams(),
    listCompetition({ pageNum: 1, pageSize: 5 }),
    getMyResults(),
    listNoticeTop()
  ])

  const applies = applyRes.status === 'fulfilled' ? (applyRes.value.data || []) : []
  const teams = teamRes.status === 'fulfilled' ? (teamRes.value.data || []) : []
  myEntries.value = normalizeEntries(applies, teams)
  recommended.value = competitionRes.status === 'fulfilled' ? (competitionRes.value.rows || competitionRes.value.data || []).slice(0, 4) : []
  competitionTotal.value = competitionRes.status === 'fulfilled' ? Number(competitionRes.value.total || recommended.value.length) : 0
  const results = resultRes.status === 'fulfilled' ? (resultRes.value.data || resultRes.value.rows || []) : []
  resultCount.value = Array.isArray(results) ? results.length : 0
  const noticeData = noticeRes.status === 'fulfilled' ? (noticeRes.value.data || noticeRes.value.rows || []) : []
  notices.value = Array.isArray(noticeData) ? noticeData.slice(0, 5) : []
  loading.value = false
})
</script>

<style scoped>
.student-home {
  --blue: #1a73e8;
  --ink: #25272b;
  --muted: #73777f;
  --surface: var(--el-bg-color-overlay, #fff);
  max-width: 1240px;
  margin: 0 auto;
  color: var(--ink);
}

.welcome-panel {
  position: relative;
  min-height: 270px;
  display: grid;
  grid-template-columns: minmax(0, 1fr) 280px;
  align-items: center;
  gap: 72px;
  padding: 44px 52px;
  overflow: hidden;
  border-radius: 18px;
  background: linear-gradient(135deg, #f8fbff 0%, #eef4ff 100%);
}
.welcome-panel::after {
  content: '';
  position: absolute;
  right: -90px;
  bottom: -120px;
  width: 330px;
  height: 330px;
  border-radius: 50%;
  background: rgba(26, 115, 232, .06);
}
.welcome-copy { position: relative; z-index: 1; }
.eyebrow { display: block; margin-bottom: 10px; color: #6e7f99; font-size: 13px; font-weight: 500; }
.welcome-copy h1 { margin: 0; font-size: clamp(28px, 3vw, 38px); font-weight: 650; letter-spacing: -.035em; }
.welcome-copy p { margin: 12px 0 22px; color: #626b78; font-size: 15px; }
.welcome-actions { display: flex; gap: 8px; }
.welcome-actions :deep(.el-button) { height: 38px; padding: 0 18px; border: 0; border-radius: 9px; }
.welcome-actions :deep(.el-button:not(.el-button--primary)) { background: rgba(255,255,255,.8); box-shadow: 0 1px 2px rgba(40,47,59,.06); }
.hero-stats { position:relative; z-index:1; display:flex; flex-direction:column; min-width:0; }
.hero-stat { display:flex; align-items:baseline; justify-content:space-between; gap:18px; padding:11px 2px; border-bottom:1px solid rgba(26,57,94,.09); }
.hero-stat:last-child { border-bottom:0; }
.hero-stat span { color:#708097; font-size:12px; }
.hero-stat strong { color:#26374f; font-size:28px; font-weight:600; line-height:1; letter-spacing:-.04em; }

.primary-grid { display:grid; grid-template-columns:minmax(0,1.3fr) minmax(360px,.9fr); gap:18px; margin-top:18px; }
.home-panel {
  padding:24px;
  border-radius:16px;
  background:var(--surface);
  box-shadow:inset 0 0 0 1px rgba(31,35,41,.035), 0 1px 2px rgba(41,45,52,.035);
}
.section-heading { display: flex; align-items: flex-end; justify-content: space-between; gap: 16px; margin-bottom: 18px; }
.section-heading.simple { align-items: center; }
.section-heading h2 { margin: 2px 0 0; font-size: 18px; font-weight: 650; letter-spacing: -.02em; }
.section-kicker { color: #92969c; font-size: 12px; }
.text-action { display: inline-flex; align-items: center; gap: 4px; padding: 0; color: #747982; border: 0; background: none; cursor: pointer; font-size: 13px; }
.text-action:hover { color: var(--blue); }

.task-list { display: flex; flex-direction: column; }
.task-item { width: 100%; display: flex; align-items: center; gap: 14px; padding: 15px 4px; text-align: left; border: 0; border-bottom: 1px solid rgba(31,35,41,.055); background: transparent; cursor: pointer; }
.task-item:last-child { border-bottom: 0; }
.task-item:hover .task-content strong,.task-item:hover .task-action { color: var(--blue); }
.task-state { width: 30px; height: 30px; flex: none; display: grid; place-items: center; border-radius: 9px; background: #eef4ff; }
.task-state span { width: 8px; height: 8px; border-radius: 50%; background: #1a73e8; }
.task-state.amber { background:#fff3df }.task-state.amber span { background:#d18420 }
.task-state.green { background:#e9f6ef }.task-state.green span { background:#2b9a6b }
.task-state.violet { background:#f3ecfa }.task-state.violet span { background:#8a61b4 }
.task-content { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 4px; }
.task-content strong { overflow: hidden; color: var(--ink); font-size: 14px; font-weight: 600; text-overflow: ellipsis; white-space: nowrap; transition: color .18s; }
.task-content small { overflow: hidden; color: #848890; font-size: 12px; text-overflow: ellipsis; white-space: nowrap; }
.task-action { display: inline-flex; align-items: center; gap: 3px; color: #7d8289; font-size: 12px; white-space: nowrap; transition: color .18s; }

.quick-panel { margin-top:18px; }
.quick-list { display:flex; gap:12px; }
.quick-item { position:relative; flex:1 1 0; min-width:0; min-height:132px; display:flex; flex-direction:column; align-items:flex-start; gap:12px; padding:16px; text-align:left; border:0; border-radius:12px; background:#f7faff; cursor:pointer; transition:transform .18s ease-out, box-shadow .18s ease-out; }
.quick-item:nth-child(2) { background:#f5faf7; }
.quick-item:nth-child(3) { background:#fffaf2; }
.quick-item:nth-child(4) { background:#faf7fd; }
.quick-item:hover { box-shadow:0 9px 22px rgba(38,43,51,.09); transform:translateY(-2px); }
.quick-icon { width: 40px; height: 40px; flex: none; display: grid; place-items: center; border-radius: 10px; font-size: 19px; }
.quick-item > span:nth-child(2) { display:flex; flex-direction:column; gap:5px; min-width:0; }
.quick-item strong { font-size:14px; font-weight:600; }.quick-item small { color:#898d94; font-size:11px; line-height:1.45; }
.quick-arrow { position:absolute; top:18px; right:16px; color:#b2b5ba; }

.recommend-list { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 10px; }
.recommend-item { min-width: 0; display: flex; align-items: center; gap: 13px; padding: 12px; text-align: left; border: 0; border-radius: 12px; background: #fafbfc; cursor: pointer; transition: transform .18s, box-shadow .18s, background .18s; }
.recommend-item:hover { background:#fff; box-shadow:0 8px 22px rgba(38,43,51,.075); transform:translateY(-2px); }
.recommend-cover { width: 74px; height: 60px; flex:none; display:grid; place-items:center; overflow:hidden; border-radius:10px; color:#5d7eb4; background:linear-gradient(135deg,#eff5ff,#e3edff); font-size:22px; }
.recommend-cover.cover-1 { color:#57816a; background:linear-gradient(135deg,#eff9f3,#e2f2e8); }
.recommend-cover.cover-2 { color:#956f38; background:linear-gradient(135deg,#fff8e9,#ffedcc); }
.recommend-cover img { width:100%; height:100%; object-fit:cover; }
.recommend-copy { flex:1; min-width:0; display:flex; flex-direction:column; gap:4px; }
.recommend-copy > strong { overflow:hidden; font-size:13px; font-weight:600; text-overflow:ellipsis; white-space:nowrap; }
.recommend-copy > small { overflow:hidden; color:#8b8f96; font-size:11px; text-overflow:ellipsis; white-space:nowrap; }
.recommend-meta { display:flex; align-items:center; gap:7px; margin-top:2px; color:#777c83; font-size:10px; }
.recommend-meta em { padding:2px 5px; color:#3e6fae; border-radius:4px; background:#eaf2fe; font-style:normal; }
.recommend-arrow { flex:none; color:#b6b9be; }

.notice-list { display:flex; flex-direction:column; gap:2px; }
.notice-item { display:flex; gap:10px; padding:11px 3px; }
.notice-dot { width:7px; height:7px; flex:none; margin-top:5px; border-radius:50%; background:#1a73e8; }
.notice-dot.dot-1 { background:#d18420 }.notice-dot.dot-2 { background:#2b9a6b }
.notice-item > div { min-width:0; display:flex; flex-direction:column; gap:5px; }
.notice-item strong { overflow:hidden; font-size:13px; font-weight:500; line-height:1.35; text-overflow:ellipsis; white-space:nowrap; }
.notice-item time { color:#a0a3a8; font-size:11px; }
.unread-count { padding:3px 7px; color:#1a73e8; border-radius:999px; background:#eaf2fe; font-size:10px; }

.bottom-grid { display:grid; grid-template-columns:minmax(0,1.15fr) minmax(360px,.85fr); gap:18px; margin-top:18px; }
.notice-panel,.platform-panel { min-height:238px; }
.platform-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:10px; }
.platform-item { min-height:72px; display:flex; flex-direction:column; justify-content:center; gap:7px; padding:13px 15px; border-radius:10px; background:#fafafa; }
.platform-item span { color:#92969c; font-size:11px; }
.platform-item strong { color:#3e4248; font-size:15px; font-weight:600; }
.platform-item strong.healthy { color:#25835c; }

.empty-note { min-height:92px; display:flex; align-items:center; gap:12px; color:#858990; font-size:13px; }
.empty-note strong { color:#4b4f55; font-size:14px; }.empty-note p { margin:4px 0 0; font-size:12px; }
.empty-note .el-button { margin-left:auto; }.empty-note.compact { min-height:56px; justify-content:center; }
.empty-icon { width:34px; height:34px; flex:none; display:grid; place-items:center; color:#2b9a6b; border-radius:10px; background:#e9f6ef; }

@media (max-width: 980px) {
  .primary-grid,.bottom-grid { grid-template-columns:1fr; }
  .quick-list { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); }
}
@media (max-width: 720px) {
  .welcome-panel { min-height:auto; grid-template-columns:1fr; gap:26px; padding:28px 24px; }
  .hero-stats { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:0 22px; }
  .hero-stat:nth-last-child(2) { border-bottom:0; }
  .primary-grid,.bottom-grid { display:flex; flex-direction:column; }
  .quick-list { grid-template-columns:1fr; }
  .quick-item { min-height:108px; }
  .recommend-list { grid-template-columns:1fr; }
  .home-panel { padding:20px 17px; }
  .task-action { display:none; }
}
</style>
