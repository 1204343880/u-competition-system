<template>
  <div class="agent-chat">
    <div class="chat-header">
      <div class="chat-header-icon">
        <el-icon :size="18"><ChatDotRound /></el-icon>
      </div>
      <div class="chat-header-text">
        <span class="chat-header-title">竞赛助手</span>
        <span class="chat-header-sub">基于你的画像和学校数据回答</span>
      </div>
      <el-icon class="chat-header-close" :size="18" @click="$emit('close')"><Close /></el-icon>
    </div>
    <div class="chat-messages" ref="msgList">
      <div v-for="(msg, idx) in messages" :key="idx" class="chat-msg" :class="msg.role">
        <div v-if="msg.role === 'ai' && msg.content" class="msg-bubble ai-bubble">
          {{ msg.content }}
        </div>
        <div v-if="msg.role === 'user'" class="msg-bubble user-bubble">
          {{ msg.content }}
        </div>
        <div v-if="msg.role === 'ai' && msg.steps && msg.steps.length" class="msg-steps">
          <span v-for="(step, si) in msg.steps" :key="si" class="step-dot" />
        </div>
      </div>
      <!-- 推荐卡片区域 -->
      <div v-if="recommendations.length > 0 && !loading" class="rec-cards">
        <div class="rec-cards-header">
          <el-icon :size="16"><Trophy /></el-icon>
          <span>为你推荐的竞赛</span>
        </div>
        <div class="rec-context">
          <span>当前策略：{{ recommendationPlan?.strategy_label || strategyLabel }}</span>
          <span v-if="recommendationPlan?.applied_filters?.length">
            当前约束：{{ recommendationPlan.applied_filters.join(' · ') }}
          </span>
        </div>
        <div
          v-for="rec in recommendations"
          :key="rec.competition_id || rec.rank"
          class="rec-card"
          @click="navigateToCompetition(rec)"
        >
          <div class="rec-card-top">
            <span class="rec-rank">#{{ rec.rank }}</span>
            <span class="rec-name">{{ rec.competition_name }}</span>
            <span class="rec-score">{{ rec.match_score.toFixed(0) }}分</span>
          </div>
          <div v-if="rec.match_reasons && rec.match_reasons.length" class="rec-reasons">
            <span v-for="(reason, ri) in rec.match_reasons" :key="ri" class="rec-tag">{{ reason }}</span>
          </div>
          <div v-if="rec.ability_gaps && rec.ability_gaps.length" class="rec-gaps">
            <span class="gap-label">能力缺口：</span>
            <span v-for="(gap, gi) in rec.ability_gaps" :key="gi" class="gap-tag">{{ gap }}</span>
          </div>
          <div v-if="rec.deadline" class="rec-deadline">
            <el-icon :size="12"><Clock /></el-icon>
            <span>截止：{{ rec.deadline }}</span>
          </div>
          <div class="rec-card-action">
            <span>查看详情 <el-icon :size="12"><ArrowRight /></el-icon></span>
          </div>
        </div>
      </div>
      <div v-if="loading" class="chat-typing">
        <span class="dot" />
        <span class="dot" />
        <span class="dot" />
      </div>
    </div>
    <div class="chat-input">
      <div class="strategy-switcher">
        <button
          v-for="item in strategies"
          :key="item.value"
          type="button"
          class="strategy-chip"
          :class="{ active: currentStrategy === item.value }"
          :disabled="loading"
          @click="switchStrategy(item.value)"
        >
          {{ item.label }}
        </button>
      </div>
      <div class="chat-input-row">
      <el-input
        v-model="input"
        placeholder="输入你的问题..."
        :disabled="loading"
        @keyup.enter="send"
      />
      <el-button type="primary" :disabled="loading || !input.trim()" @click="send">
        <el-icon><Promotion /></el-icon>
      </el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, nextTick, onUnmounted, watch, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ArrowRight, ChatDotRound, Clock, Close, Promotion, Trophy } from '@element-plus/icons-vue'
import { getToken } from '@/utils/auth'

const router = useRouter()
const route = useRoute()

const emit = defineEmits(['close'])
const input = ref('')
const loading = ref(false)
const sessionId = ref('')
const messages = ref([])
const msgList = ref(null)
const recommendationPlan = ref(null)
const recommendations = ref([])
const currentContext = ref(null)
const currentStrategy = ref('balanced')
const strategyOverrideActive = ref(false)
const lastQuestion = ref('')
const traceId = ref('')
const strategies = [
  { value: 'balanced', label: '综合收益' },
  { value: 'winability', label: '获奖可行性' },
  { value: 'prestige', label: '含金量成长' },
  { value: 'short_cycle', label: '短周期参赛' },
  { value: 'newbie', label: '新手友好' }
]
const strategyLabel = computed(() => strategies.find(item => item.value === currentStrategy.value)?.label || '综合收益')
const baseApi = import.meta.env.VITE_APP_BASE_API || ''

let abortController = null

// Q3: 用 route watch 替代 window 全局变量
watch(() => route.params.competitionId, (id) => {
  if (id) {
    currentContext.value = {
      competition_id: id,
      competition_name: route.query.name || '',
      page_type: 'hall_detail'
    }
  } else {
    currentContext.value = null
  }
}, { immediate: true })

function timeNow() {
  return new Date().toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' })
}
async function scrollBottom() {
  await nextTick()
  if (msgList.value) {
    msgList.value.scrollTop = msgList.value.scrollHeight
  }
}

async function send(overrideText = '', strategyOverride = '') {
  const text = (typeof overrideText === 'string' ? overrideText : input.value).trim()
  if (!text || loading.value) return

  input.value = ''
  lastQuestion.value = text
  loading.value = true
  recommendations.value = []
  recommendationPlan.value = null

  messages.value.push({ role: 'user', content: text, time: timeNow() })
  const aiMsg = { role: 'ai', content: '', steps: [], time: '' }
  messages.value.push(aiMsg)
  await scrollBottom()

  // Q3: 用组件级 currentContext + 消费 window.__pendingAgentContext 作为兜底
  const context = currentContext.value || window.__pendingAgentContext || null
  window.__pendingAgentContext = null

  const body = { message: text, session_id: sessionId.value }
  const selectedStrategy = strategyOverride || (strategyOverrideActive.value ? currentStrategy.value : '')
  if (selectedStrategy) body.recommendation_strategy = selectedStrategy
  if (context) body.context = context

  abortController = new AbortController()
  try {
    const response = await fetch(`${baseApi}/student/agent/chat`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + getToken()
      },
      body: JSON.stringify(body),
      signal: abortController.signal
    })

    if (!response.ok || !response.body) {
      throw new Error(`HTTP ${response.status}`)
    }

    const reader = response.body.getReader()
    const decoder = new TextDecoder()
    let buffer = ''
    let sseEvent = ''

    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      buffer += decoder.decode(value, { stream: true })
      const lines = buffer.split('\n')
      buffer = lines.pop() || ''
      for (const line of lines) {
        if (line.startsWith('event: ')) {
          sseEvent = line.slice(7).trim()
        } else if (line.startsWith('data: ')) {
          try {
            const payload = JSON.parse(line.slice(6))
            handleEvent(sseEvent, payload)
            sseEvent = ''
          } catch {}
        }
      }
    }
  } catch (e) {
    if (e.name !== 'AbortError') {
      aiMsg.content += '\n\n连接出错，请重试'
      recommendations.value = []
      recommendationPlan.value = null
    }
  }
  loading.value = false
  aiMsg.time = timeNow()
}

function switchStrategy(strategy) {
  currentStrategy.value = strategy
  strategyOverrideActive.value = true
  if (lastQuestion.value && !loading.value) {
    send(lastQuestion.value, strategy)
  }
}

function handleEvent(event, payload) {
  const aiMsg = messages.value[messages.value.length - 1]
  if (!aiMsg || aiMsg.role !== 'ai') return

  if (event === 'session') {
    sessionId.value = payload.session_id
    traceId.value = payload.trace_id || ''
  } else if (event === 'step') {
    const data = typeof payload === 'string' ? JSON.parse(payload) : payload
    aiMsg.steps.push({ tool: data.tool, status: data.status || 'ok' })
    // Task 1: 从 step 事件中提取 recommendation_plan 数据
    if (data.tool === 'recommendation_plan' && ['ok', 'needs_clarification'].includes(data.status)) {
      const plan = data.result?.recommendation_plan
      if (plan) {
        recommendationPlan.value = plan
        currentStrategy.value = plan.strategy || currentStrategy.value
        traceId.value = plan.trace_id || traceId.value
        // Task 2: 渲染推荐卡片
        recommendations.value = (plan.recommendations || []).map(item => ({
          competition_id: item.competition_id,
          competition_name: item.competition_name,
          match_score: item.match_score,
          match_reasons: (item.match_reasons || []).slice(0, 3),
          ability_gaps: (item.ability_gaps || []).slice(0, 3),
          deadline: item.deadline || '',
          rank: item.rank
        }))
      }
    }
  } else if (event === 'token') {
    const data = typeof payload === 'string' ? JSON.parse(payload) : payload
    aiMsg.content += (data.content || data.token || '')
  } else if (event === 'error') {
    const data = typeof payload === 'string' ? JSON.parse(payload) : payload
    recommendations.value = []
    recommendationPlan.value = null
    aiMsg.content = data.error || 'Agent 服务暂不可用，请稍后重试'
  }
  scrollBottom()
}

function navigateToCompetition(rec) {
  window.__pendingAgentContext = {
    competition_id: rec.competition_id,
    competition_name: rec.competition_name,
    page_type: 'hall_detail'
  }
  router.push(`/student/hall/detail/${rec.competition_id}`)
  emit('close')
}

// Q3: route watch 已在上面定义，处理当前页面上下文变化

onUnmounted(() => {
  if (abortController) abortController.abort()
})
</script>

<style scoped>
.agent-chat { display: flex; flex-direction: column; height: 100%; background: #fff; }
.chat-header { display: flex; align-items: center; padding: 16px 20px; border-bottom: 1px solid #eef0f2; flex-shrink: 0; }
.chat-header-icon { width: 36px; height: 36px; border-radius: 50%; background: rgba(99,102,241,.1); color: #6366f1; display: flex; align-items: center; justify-content: center; }
.chat-header-text { margin-left: 10px; flex: 1; display: flex; flex-direction: column; }
.chat-header-title { font-size: 15px; font-weight: 700; color: #1e293b; }
.chat-header-sub { font-size: 11px; color: #94a3b8; }
.chat-header-close { color: #94a3b8; cursor: pointer; flex-shrink: 0; }
.chat-messages { flex: 1; overflow-y: auto; padding: 16px; min-height: 0; }
.chat-msg { margin-bottom: 12px; display: flex; flex-direction: column; }
.msg-bubble { max-width: 85%; padding: 10px 14px; border-radius: 16px; font-size: 14px; line-height: 1.5; word-break: break-word; }
.user-bubble { align-self: flex-end; background: #6366f1; color: #fff; border-bottom-right-radius: 4px; }
.ai-bubble { align-self: flex-start; background: #f1f5f9; color: #1e293b; border-bottom-left-radius: 4px; white-space: pre-wrap; }
.msg-steps { display: flex; gap: 4px; margin-top: 4px; margin-left: 14px; }
.step-dot { width: 5px; height: 5px; border-radius: 50%; background: #cbd5e1; }
.chat-typing { display: flex; gap: 4px; padding: 10px 16px; }
.dot { width: 7px; height: 7px; border-radius: 50%; background: #cbd5e1; animation: bounce 1.4s infinite ease-in-out both; }
.dot:nth-child(1) { animation-delay: -.32s; }
.dot:nth-child(2) { animation-delay: -.16s; }
@keyframes bounce { 0%,80%,100%{transform:scale(0)} 40%{transform:scale(1)} }
.chat-input { display: flex; flex-direction: column; gap: 8px; padding: 12px 16px; border-top: 1px solid #eef0f2; flex-shrink: 0; }
.chat-input-row { display: flex; gap: 8px; }
.strategy-switcher { display: flex; gap: 6px; overflow-x: auto; padding-bottom: 2px; }
.strategy-chip { border: 1px solid #e2e8f0; border-radius: 999px; background: #fff; color: #64748b; padding: 4px 9px; font-size: 11px; white-space: nowrap; cursor: pointer; }
.strategy-chip.active { border-color: #6366f1; background: #eef2ff; color: #4f46e5; }
.strategy-chip:disabled { cursor: not-allowed; opacity: .6; }
.error-msg { color: #ef4444; font-size: 12px; }

/* Task 2: 推荐卡片 */
.rec-cards { margin: 12px 0; padding: 14px; background: linear-gradient(135deg, #f0f4ff, #e8eeff); border-radius: 16px; border: 1px solid rgba(99,102,241,.12); }
.rec-cards-header { display: flex; align-items: center; gap: 6px; margin-bottom: 10px; font-size: 13px; font-weight: 600; color: #4f46e5; }
.rec-context { display: flex; flex-direction: column; gap: 3px; margin: -4px 0 10px; color: #64748b; font-size: 11px; }
.rec-card { padding: 12px; margin-bottom: 8px; background: #fff; border-radius: 12px; cursor: pointer; transition: transform .15s, box-shadow .15s; border: 1px solid rgba(31,35,41,.06); }
.rec-card:last-child { margin-bottom: 0; }
.rec-card:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(79,70,229,.12); border-color: rgba(79,70,229,.2); }
.rec-card-top { display: flex; align-items: center; gap: 8px; }
.rec-rank { font-size: 12px; font-weight: 700; color: #6366f1; background: rgba(99,102,241,.1); padding: 2px 8px; border-radius: 6px; }
.rec-name { flex: 1; font-size: 14px; font-weight: 600; color: #1e293b; }
.rec-score { font-size: 13px; font-weight: 700; color: #6366f1; }
.rec-reasons { display: flex; flex-wrap: wrap; gap: 4px; margin-top: 6px; }
.rec-tag { font-size: 11px; padding: 2px 8px; background: #eef2ff; color: #4f46e5; border-radius: 6px; }
.rec-gaps { margin-top: 6px; font-size: 12px; }
.gap-label { color: #94a3b8; }
.gap-tag { display: inline-block; margin: 2px 4px 2px 0; padding: 1px 6px; background: #fef2f2; color: #dc2626; border-radius: 4px; font-size: 11px; }
.rec-deadline { margin-top: 6px; font-size: 12px; color: #64748b; display: flex; align-items: center; gap: 4px; }
.rec-card-action { margin-top: 8px; text-align: right; font-size: 12px; color: #6366f1; font-weight: 600; }
</style>
