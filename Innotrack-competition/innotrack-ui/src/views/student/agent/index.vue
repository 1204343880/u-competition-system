<template>
  <section class="agent-chat">
    <header class="chat-header">
      <div class="assistant-identity">
        <div class="assistant-logo">
          <el-icon :size="24"><ChatDotRound /></el-icon>
        </div>
        <div>
          <h1>竞赛智能助手</h1>
          <p><span class="online-dot"></span>在线 · 为你提供竞赛建议</p>
        </div>
      </div>
      <button class="close-button" type="button" aria-label="关闭助手" @click="emit('close')">
        <el-icon :size="20"><Close /></el-icon>
      </button>
    </header>

    <main ref="bodyRef" class="chat-body">
      <div v-if="messages.length === 0" class="welcome-panel">
        <div class="welcome-orbit">
          <div class="welcome-logo">
            <el-icon :size="32"><ChatDotRound /></el-icon>
          </div>
        </div>
        <h2>你好，我是你的竞赛助手</h2>
        <p>我可以结合你的专业、技能和参赛经历，帮你寻找更合适的比赛与备赛方向。</p>

        <div class="quick-actions">
          <button v-for="item in quickQuestions" :key="item.text" type="button" @click="sendQuick(item.text)">
            <span class="quick-icon">{{ item.icon }}</span>
            <span>{{ item.text }}</span>
            <span class="quick-arrow">→</span>
          </button>
        </div>
      </div>

      <template v-for="(msg, idx) in messages" :key="idx">
        <div
          v-if="msg.content || msg.thinking || msg.steps?.length || !loading"
          class="chat-msg"
          :class="msg.role"
        >
          <div v-if="msg.role === 'ai'" class="msg-avatar">
            <el-icon :size="17"><ChatDotRound /></el-icon>
          </div>
          <div class="msg-content">
            <div class="msg-bubble" v-html="renderMsg(msg)"></div>
            <span v-if="msg.time" class="msg-time">{{ msg.time }}</span>
          </div>
        </div>
      </template>

      <div v-if="loading && waitingForFirstToken" class="chat-msg ai">
        <div class="msg-avatar">
          <el-icon :size="17"><ChatDotRound /></el-icon>
        </div>
        <div class="msg-content">
          <div class="msg-bubble typing">
            <span></span><span></span><span></span>
          </div>
        </div>
      </div>
    </main>

    <footer class="chat-footer">
      <div class="composer" :class="{ focused: inputFocused }">
        <el-input
          v-model="input"
          type="textarea"
          :autosize="{ minRows: 1, maxRows: 4 }"
          resize="none"
          placeholder="问问我比赛推荐、备赛方法……"
          :disabled="loading"
          @focus="inputFocused = true"
          @blur="inputFocused = false"
          @keydown.enter.exact.prevent="send"
        />
        <button
          class="send-button"
          type="button"
          aria-label="发送消息"
          :disabled="loading || !input.trim()"
          @click="send"
        >
          <el-icon :size="18"><Promotion /></el-icon>
        </button>
      </div>
      <p class="composer-tip">Enter 发送 · Shift + Enter 换行</p>
    </footer>
  </section>
</template>

<script setup>
import { computed, nextTick, ref } from 'vue'
import { ChatDotRound, Close, Promotion } from '@element-plus/icons-vue'
import { getToken } from '@/utils/auth'

const emit = defineEmits(['close'])

const input = ref('')
const inputFocused = ref(false)
const loading = ref(false)
const messages = ref([])
const bodyRef = ref(null)
const sessionId = ref(Date.now().toString(36) + Math.random().toString(36).slice(2, 8))

const quickQuestions = [
  { icon: '🏆', text: '推荐适合我的竞赛' },
  { icon: '✨', text: '分析一下我的优势' },
  { icon: '📚', text: '怎么准备蓝桥杯' },
  { icon: '👥', text: '组队有什么建议' }
]

const toolLabels = {
  search_profile: '查询个人画像',
  search_competitions: '搜索相关竞赛',
  search_retrospects: '查找往届复盘',
  search_experiences: '查找备赛经验',
  synthesis: '整理分析结果',
  intent: '理解你的问题'
}

const waitingForFirstToken = computed(() => {
  if (!loading.value) return false
  const last = messages.value[messages.value.length - 1]
  if (!last || last.role !== 'ai') return true
  return !last.content && !last.thinking && !last.steps?.length
})

function timeNow() {
  const date = new Date()
  return `${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`
}

function escapeHtml(value = '') {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

function renderInlineMarkdown(value) {
  return value
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
    .replace(/__(.+?)__/g, '<strong>$1</strong>')
    .replace(/(^|[^*])\*([^*]+)\*/g, '$1<em>$2</em>')
}

function renderMarkdown(value = '') {
  const codeBlocks = []
  const tokenized = value.replace(/```([\w-]*)\n?([\s\S]*?)```/g, (_, language, code) => {
    const index = codeBlocks.push({ language, code: code.replace(/\n$/, '') }) - 1
    return `\u0000CODE_BLOCK_${index}\u0000`
  })
  const lines = escapeHtml(tokenized).split('\n')
  const output = []
  let paragraph = []
  let listType = ''

  const closeParagraph = () => {
    if (!paragraph.length) return
    output.push(`<p>${paragraph.map(renderInlineMarkdown).join('<br>')}</p>`)
    paragraph = []
  }
  const closeList = () => {
    if (!listType) return
    output.push(`</${listType}>`)
    listType = ''
  }

  for (const line of lines) {
    const codeMatch = line.match(/^\u0000CODE_BLOCK_(\d+)\u0000$/)
    const headingMatch = line.match(/^(#{1,3})\s+(.+)$/)
    const unorderedMatch = line.match(/^\s*[-*]\s+(.+)$/)
    const orderedMatch = line.match(/^\s*\d+\.\s+(.+)$/)

    if (codeMatch) {
      closeParagraph()
      closeList()
      const block = codeBlocks[Number(codeMatch[1])]
      const languageClass = block.language ? ` class="language-${escapeHtml(block.language)}"` : ''
      output.push(`<pre><code${languageClass}>${escapeHtml(block.code)}</code></pre>`)
    } else if (headingMatch) {
      closeParagraph()
      closeList()
      const level = headingMatch[1].length
      output.push(`<h${level}>${renderInlineMarkdown(headingMatch[2])}</h${level}>`)
    } else if (unorderedMatch || orderedMatch) {
      closeParagraph()
      const nextListType = unorderedMatch ? 'ul' : 'ol'
      if (listType !== nextListType) {
        closeList()
        listType = nextListType
        output.push(`<${listType}>`)
      }
      output.push(`<li>${renderInlineMarkdown((unorderedMatch || orderedMatch)[1])}</li>`)
    } else if (!line.trim()) {
      closeParagraph()
      closeList()
    } else {
      closeList()
      paragraph.push(line)
    }
  }
  closeParagraph()
  closeList()
  return output.join('')
}

function renderMsg(msg) {
  let html = renderMarkdown(msg.content || '')
  if (msg.thinking) {
    html = `<details class="thinking-box"><summary>查看分析过程</summary>${renderMarkdown(msg.thinking)}</details>${html}`
  }
  if (msg.steps?.length) {
    const hiddenSteps = new Set(['intent', 'synthesis'])
    const visibleSteps = msg.steps.filter(step =>
      step.tool && !step.tool.startsWith('agent') && !hiddenSteps.has(step.tool)
    )
    if (visibleSteps.length) {
      const stepHtml = visibleSteps.map(step => {
        const label = toolLabels[step.tool] || step.tool
        const stateClass = step.status === 'error' ? 'is-error' : 'is-ok'
        const statusText = step.status === 'error' ? `${label}失败` : `已${label}`
        return `<div class="tool-step ${stateClass}"><i></i><span>${escapeHtml(statusText)}</span></div>`
      }).join('')
      const onlyStep = visibleSteps[0]
      const onlyLabel = toolLabels[onlyStep.tool] || onlyStep.tool
      const summary = visibleSteps.length === 1
        ? (onlyStep.status === 'error' ? `${onlyLabel}失败` : `已${onlyLabel}`)
        : `已完成 ${visibleSteps.length} 项信息查询`
      html = `<details class="thinking-box tool-box"><summary>${escapeHtml(summary)}</summary>${stepHtml}</details>${html}`
    }
  }
  return html
}

function sendQuick(text) {
  input.value = text
  send()
}

async function send() {
  const text = input.value.trim()
  if (!text || loading.value) return

  input.value = ''
  loading.value = true
  messages.value.push({ role: 'user', content: text, time: timeNow() })
  const aiMsg = { role: 'ai', content: '', thinking: '', steps: [], time: '' }
  messages.value.push(aiMsg)
  await scrollBottom()

  try {
    const response = await fetch('/student/agent/chat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${getToken()}`
      },
      body: JSON.stringify({ message: text, session_id: sessionId.value })
    })

    if (!response.ok) {
      aiMsg.content = `服务暂时不可用（${response.status}），请稍后再试。`
      return
    }

    const reader = response.body.getReader()
    const decoder = new TextDecoder()
    let buffer = ''
    let currentEvent = ''

    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      buffer += decoder.decode(value, { stream: true })
      const lines = buffer.split('\n')
      buffer = lines.pop() || ''

      for (const line of lines) {
        if (line.startsWith('event: ')) {
          currentEvent = line.slice(7).trim()
        } else if (line.startsWith('data: ')) {
          try {
            handleEvent(currentEvent, JSON.parse(line.slice(6)))
          } catch {
            // Ignore incomplete SSE data and continue reading the stream.
          }
        }
      }
      await scrollBottom()
    }
  } catch {
    aiMsg.content = '连接失败，请确认智能助手服务已经启动。'
  } finally {
    loading.value = false
    aiMsg.time = timeNow()
    await scrollBottom()
  }

  function handleEvent(event, payload) {
    if (event === 'session') {
      sessionId.value = payload.session_id
    } else if (event === 'intent') {
      aiMsg.steps.push({ tool: 'intent', status: 'ok' })
    } else if (event === 'step') {
      const runningIndex = aiMsg.steps.findIndex(step =>
        step.tool === payload.tool && step.status === 'running'
      )
      if (payload.status !== 'running' && runningIndex >= 0) {
        aiMsg.steps[runningIndex] = { tool: payload.tool, status: payload.status }
      } else {
        aiMsg.steps.push({ tool: payload.tool, status: payload.status })
      }
    } else if (event === 'reasoning') {
      const content = typeof payload === 'string' ? payload : (payload.content || '')
      if (content) aiMsg.thinking += content
    } else if (event === 'token') {
      aiMsg.content += payload.token || ''
    } else if (event === 'error') {
      aiMsg.content += `\n服务错误：${payload.error}`
    }
  }
}

async function scrollBottom() {
  await nextTick()
  if (bodyRef.value) bodyRef.value.scrollTop = bodyRef.value.scrollHeight
}
</script>

<style scoped>
.agent-chat {
  --agent-primary: #2563eb;
  --agent-violet: #7c3aed;
  display: flex;
  flex-direction: column;
  height: 100%;
  color: var(--el-text-color-primary, #172033);
  background: var(--el-bg-color, #fff);
}

.chat-header {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 84px;
  padding: 14px 20px;
  color: #fff;
  background:
    radial-gradient(circle at 84% 10%, rgba(255, 255, 255, .2), transparent 32%),
    linear-gradient(135deg, #2563eb 0%, #5b4ee8 52%, #7c3aed 100%);
  box-shadow: 0 8px 24px rgba(67, 56, 202, .18);
  flex-shrink: 0;
}

.assistant-identity { display: flex; align-items: center; gap: 12px; }
.assistant-logo {
  display: grid;
  width: 48px;
  height: 48px;
  place-items: center;
  border: 1px solid rgba(255, 255, 255, .34);
  border-radius: 16px;
  background: rgba(255, 255, 255, .18);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, .24);
  backdrop-filter: blur(8px);
}
.assistant-identity h1 { margin: 0; font-size: 17px; font-weight: 700; letter-spacing: .02em; }
.assistant-identity p { display: flex; align-items: center; gap: 6px; margin: 5px 0 0; font-size: 12px; color: rgba(255, 255, 255, .78); }
.online-dot { width: 7px; height: 7px; border-radius: 50%; background: #6ee7b7; box-shadow: 0 0 0 3px rgba(110, 231, 183, .18); }
.close-button {
  display: grid;
  width: 38px;
  height: 38px;
  padding: 0;
  place-items: center;
  color: rgba(255, 255, 255, .88);
  border: 0;
  border-radius: 12px;
  background: rgba(255, 255, 255, .1);
  cursor: pointer;
  transition: background .2s, transform .2s;
}
.close-button:hover { background: rgba(255, 255, 255, .2); transform: rotate(4deg); }

.chat-body {
  flex: 1;
  min-height: 0;
  padding: 24px 20px;
  overflow-y: auto;
  scroll-behavior: smooth;
  background:
    radial-gradient(circle at 0 0, rgba(37, 99, 235, .055), transparent 28%),
    var(--el-fill-color-extra-light, #f8fafc);
}
.chat-body::-webkit-scrollbar { width: 5px; }
.chat-body::-webkit-scrollbar-thumb { border-radius: 10px; background: rgba(148, 163, 184, .45); }

.welcome-panel { max-width: 390px; margin: 42px auto 0; text-align: center; }
.welcome-orbit {
  display: grid;
  width: 92px;
  height: 92px;
  margin: 0 auto 22px;
  place-items: center;
  border: 1px solid rgba(99, 102, 241, .14);
  border-radius: 50%;
  background: rgba(99, 102, 241, .055);
  box-shadow: 0 0 0 12px rgba(99, 102, 241, .025);
}
.welcome-logo {
  display: grid;
  width: 62px;
  height: 62px;
  place-items: center;
  color: #fff;
  border-radius: 21px;
  background: linear-gradient(135deg, var(--agent-primary), var(--agent-violet));
  box-shadow: 0 12px 28px rgba(79, 70, 229, .28);
}
.welcome-panel h2 { margin: 0; font-size: 20px; font-weight: 700; }
.welcome-panel > p { max-width: 340px; margin: 11px auto 24px; color: var(--el-text-color-secondary, #64748b); font-size: 13px; line-height: 1.75; }
.quick-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; text-align: left; }
.quick-actions button {
  display: grid;
  grid-template-columns: 28px 1fr auto;
  align-items: center;
  gap: 8px;
  min-height: 58px;
  padding: 10px 12px;
  color: var(--el-text-color-regular, #334155);
  font-size: 12px;
  line-height: 1.4;
  border: 1px solid var(--el-border-color-lighter, #e5eaf3);
  border-radius: 14px;
  background: var(--el-bg-color-overlay, #fff);
  box-shadow: 0 3px 12px rgba(15, 23, 42, .035);
  cursor: pointer;
  transition: border-color .2s, box-shadow .2s, transform .2s;
}
.quick-actions button:hover { border-color: rgba(79, 70, 229, .32); box-shadow: 0 8px 20px rgba(79, 70, 229, .09); transform: translateY(-2px); }
.quick-icon { display: grid; width: 28px; height: 28px; place-items: center; border-radius: 9px; background: rgba(99, 102, 241, .08); }
.quick-arrow { color: #94a3b8; font-size: 15px; }

.chat-msg { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 20px; }
.chat-msg.user { justify-content: flex-end; }
.msg-avatar {
  display: grid;
  width: 34px;
  height: 34px;
  flex: 0 0 34px;
  place-items: center;
  color: #fff;
  border-radius: 12px;
  background: linear-gradient(135deg, var(--agent-primary), var(--agent-violet));
  box-shadow: 0 5px 14px rgba(79, 70, 229, .2);
}
.msg-content { display: flex; max-width: 80%; flex-direction: column; }
.chat-msg.user .msg-content { align-items: flex-end; }
.msg-bubble {
  padding: 11px 14px;
  color: var(--el-text-color-primary, #1e293b);
  font-size: 14px;
  line-height: 1.7;
  word-break: break-word;
  border: 1px solid var(--el-border-color-extra-light, #eef2f7);
  border-radius: 5px 16px 16px 16px;
  background: var(--el-bg-color-overlay, #fff);
  box-shadow: 0 4px 16px rgba(15, 23, 42, .055);
}
.chat-msg.user .msg-bubble {
  color: #fff;
  border: 0;
  border-radius: 16px 5px 16px 16px;
  background: linear-gradient(135deg, #2f72e8, #4f46e5);
  box-shadow: 0 7px 18px rgba(37, 99, 235, .18);
}
.msg-time { margin-top: 5px; padding: 0 4px; color: var(--el-text-color-placeholder, #94a3b8); font-size: 10px; }

.msg-bubble :deep(.thinking-box) {
  margin: 0 0 9px;
  padding: 8px 10px;
  color: var(--el-text-color-secondary, #64748b);
  font-size: 11px;
  border: 1px solid rgba(99, 102, 241, .14);
  border-radius: 9px;
  background: rgba(99, 102, 241, .055);
}
.msg-bubble :deep(.thinking-box summary) { color: #6366f1; font-weight: 600; cursor: pointer; }
.msg-bubble :deep(.thinking-box summary:focus) { outline: none; }
.msg-bubble :deep(.tool-step) { display: flex; align-items: center; gap: 7px; margin-top: 7px; }
.msg-bubble :deep(.tool-step i) { width: 6px; height: 6px; border-radius: 50%; background: #22c55e; }
.msg-bubble :deep(.tool-step.is-error i) { background: #ef4444; }
.msg-bubble :deep(p) { margin: 0 0 9px; }
.msg-bubble :deep(p:last-child) { margin-bottom: 0; }
.msg-bubble :deep(h1),
.msg-bubble :deep(h2),
.msg-bubble :deep(h3) { margin: 4px 0 9px; line-height: 1.4; }
.msg-bubble :deep(h1) { font-size: 18px; }
.msg-bubble :deep(h2) { font-size: 16px; }
.msg-bubble :deep(h3) { font-size: 15px; }
.msg-bubble :deep(ul),
.msg-bubble :deep(ol) { margin: 7px 0; padding-left: 22px; }
.msg-bubble :deep(li) { margin: 3px 0; }
.msg-bubble :deep(code) {
  padding: 2px 5px;
  color: #7c3aed;
  border-radius: 5px;
  background: rgba(124, 58, 237, .08);
  font-family: Consolas, Monaco, monospace;
  font-size: .9em;
}
.msg-bubble :deep(pre) {
  margin: 9px 0;
  padding: 12px;
  overflow-x: auto;
  color: #e2e8f0;
  border-radius: 10px;
  background: #172033;
}
.msg-bubble :deep(pre code) { padding: 0; color: inherit; background: transparent; }
.typing { display: flex; gap: 5px; padding: 15px 17px; }
.typing span { width: 6px; height: 6px; border-radius: 50%; background: #818cf8; animation: pulse 1.25s infinite ease-in-out; }
.typing span:nth-child(2) { animation-delay: .15s; }
.typing span:nth-child(3) { animation-delay: .3s; }
@keyframes pulse { 0%, 60%, 100% { opacity: .3; transform: translateY(0); } 30% { opacity: 1; transform: translateY(-3px); } }

.chat-footer {
  padding: 14px 18px 12px;
  border-top: 1px solid var(--el-border-color-extra-light, #eef2f7);
  background: var(--el-bg-color-overlay, #fff);
  box-shadow: 0 -8px 24px rgba(15, 23, 42, .035);
  flex-shrink: 0;
}
.composer {
  display: flex;
  align-items: flex-end;
  gap: 10px;
  padding: 8px 8px 8px 14px;
  border: 1px solid var(--el-border-color, #dbe2ea);
  border-radius: 17px;
  background: var(--el-fill-color-blank, #fff);
  transition: border-color .2s, box-shadow .2s;
}
.composer.focused { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, .1); }
.composer :deep(.el-textarea__inner) { min-height: 36px !important; padding: 8px 0; line-height: 20px; border: 0; box-shadow: none; background: transparent; }
.send-button {
  display: grid;
  width: 38px;
  height: 38px;
  flex: 0 0 38px;
  padding: 0;
  place-items: center;
  color: #fff;
  border: 0;
  border-radius: 12px;
  background: linear-gradient(135deg, var(--agent-primary), var(--agent-violet));
  box-shadow: 0 6px 14px rgba(79, 70, 229, .22);
  cursor: pointer;
  transition: opacity .2s, transform .2s;
}
.send-button:hover:not(:disabled) { transform: translateY(-1px); }
.send-button:disabled { opacity: .35; cursor: not-allowed; box-shadow: none; }
.composer-tip { margin: 7px 4px 0; color: var(--el-text-color-placeholder, #94a3b8); font-size: 10px; text-align: center; }

@media (max-width: 640px) {
  .chat-header { min-height: 76px; padding: 11px 15px; }
  .assistant-logo { width: 44px; height: 44px; border-radius: 14px; }
  .chat-body { padding: 20px 14px; }
  .welcome-panel { margin-top: 26px; }
  .quick-actions { grid-template-columns: 1fr; }
  .msg-content { max-width: 86%; }
  .chat-footer { padding: 11px 12px 9px; }
}
</style>
