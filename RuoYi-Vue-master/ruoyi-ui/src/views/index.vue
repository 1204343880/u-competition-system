<template>
  <div class="app-container home">
    <!-- 欢迎横幅 -->
    <div class="hero-section">
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">学科竞赛管理系统</h1>
          <p class="hero-subtitle">薪火互联-高校竞赛全流程管理系统</p>
          <div class="hero-meta">
            <span class="meta-item">
              <el-icon><User /></el-icon> {{ userName }}
            </span>
            <span class="meta-item">
              <el-icon><Clock /></el-icon> {{ currentTime }}
            </span>
            <span class="meta-item">
              <el-icon><Calendar /></el-icon> {{ currentDate }}
            </span>
          </div>
        </div>
        <div class="hero-decoration">
          <div class="deco-shape shape-1"></div>
          <div class="deco-shape shape-2"></div>
          <div class="deco-shape shape-3"></div>
        </div>
      </div>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :xs="24" :sm="12" :md="6" v-for="stat in statsData" :key="stat.label">
        <div class="stat-card" :style="{ borderTopColor: stat.color }">
          <div class="stat-icon" :style="{ backgroundColor: stat.bgColor }">
            <el-icon :style="{ color: stat.color }"><component :is="stat.icon" /></el-icon>
          </div>
          <div class="stat-info">
            <span class="stat-label">{{ stat.label }}</span>
            <span class="stat-value">{{ stat.value }}</span>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 快捷入口 + 通知 -->
    <el-row :gutter="20">
      <el-col :xs="24" :md="16">
        <el-card shadow="never" class="section-card">
          <template #header>
            <div class="card-header">
              <span class="card-title">快捷功能</span>
            </div>
          </template>
          <el-row :gutter="16">
            <el-col :xs="12" :sm="6" v-for="item in quickActions" :key="item.title">
              <div class="quick-card" @click="$router.push(item.path)">
                <div class="quick-icon-wrap" :style="{ backgroundColor: item.bgColor }">
                  <el-icon :style="{ color: item.color, fontSize: '28px' }"><component :is="item.icon" /></el-icon>
                </div>
                <span class="quick-title">{{ item.title }}</span>
                <span class="quick-desc">{{ item.desc }}</span>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>

      <el-col :xs="24" :md="8">
        <el-card shadow="never" class="section-card notice-card">
          <template #header>
            <div class="card-header">
              <span class="card-title">系统公告</span>
            </div>
          </template>
          <div class="notice-list">
            <div class="notice-item" v-for="notice in notices" :key="notice.title">
              <div class="notice-dot" :style="{ backgroundColor: notice.color }"></div>
              <div class="notice-content">
                <p class="notice-title">{{ notice.title }}</p>
                <span class="notice-time">{{ notice.time }}</span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 技术架构 -->
    <el-row :gutter="20">
      <el-col :span="24">
        <el-card shadow="never" class="section-card">
          <template #header>
            <div class="card-header">
              <span class="card-title">系统信息</span>
            </div>
          </template>
          <el-row :gutter="16">
            <el-col :xs="12" :sm="6">
              <div class="tech-item">
                <span class="tech-label">系统版本</span>
                <span class="tech-value">v3.9.2</span>
              </div>
            </el-col>
            <el-col :xs="12" :sm="6">
              <div class="tech-item">
                <span class="tech-label">后端框架</span>
                <span class="tech-value">SpringBoot</span>
              </div>
            </el-col>
            <el-col :xs="12" :sm="6">
              <div class="tech-item">
                <span class="tech-label">前端框架</span>
                <span class="tech-value">Vue 3 + Element Plus</span>
              </div>
            </el-col>
            <el-col :xs="12" :sm="6">
              <div class="tech-item">
                <span class="tech-label">运行模式</span>
                <span class="tech-value status-ok">正常</span>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { User, Clock, Calendar, Trophy, List, Edit, Document, Check, Collection } from '@element-plus/icons-vue'
import useUserStore from '@/store/modules/user'

const userStore = useUserStore()
const userName = computed(() => userStore.nickName || userStore.name || 'admin')

const currentDate = ref('')
const currentTime = ref('')
let timer = null

const statsData = ref([
  { label: '竞赛总数', value: '--', icon: 'Trophy', color: '#409EFF', bgColor: '#ecf5ff' },
  { label: '报名人数', value: '--', icon: 'User', color: '#67C23A', bgColor: '#f0f9eb' },
  { label: '进行中', value: '--', icon: 'Clock', color: '#E6A23C', bgColor: '#fdf6ec' },
  { label: '已结束', value: '--', icon: 'Check', color: '#F56C6C', bgColor: '#fef0f0' }
])

const quickActions = [
  { title: '比赛官网', desc: '浏览竞赛信息', icon: 'Collection', color: '#409EFF', bgColor: '#ecf5ff', path: '/competition-portal' },
  { title: '我的竞赛', desc: '已报名竞赛', icon: 'Document', color: '#67C23A', bgColor: '#f0f9eb', path: '/my-competition' },
  { title: '竞赛列表', desc: '查看全部竞赛', icon: 'List', color: '#E6A23C', bgColor: '#fdf6ec', path: '/competition/list' },
  { title: '比赛维护', desc: '管理竞赛信息', icon: 'Edit', color: '#9b59b6', bgColor: '#f4f0f9', path: '/competition-admin' }
]

const notices = [
  { title: '欢迎使用学科竞赛管理系统', time: '刚刚', color: '#409EFF' },
  { title: '系统已配置三级角色权限体系', time: '今日', color: '#67C23A' },
  { title: '竞赛信息管理模块已就绪', time: '今日', color: '#E6A23C' }
]

function updateTime() {
  const now = new Date()
  currentDate.value = now.toLocaleDateString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit', weekday: 'short' })
  currentTime.value = now.toLocaleTimeString('zh-CN', { hour12: false })
}

onMounted(() => {
  updateTime()
  timer = setInterval(updateTime, 1000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped lang="scss">
.home {
  padding: 0;
}

/* ====== 欢迎横幅 ====== */
.hero-section {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  border-radius: 16px;
  margin-bottom: 20px;
  overflow: hidden;
  position: relative;
}

.hero-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 40px 48px;
  position: relative;
  z-index: 1;
}

.hero-text {
  color: #fff;
}

.hero-title {
  font-size: 36px;
  font-weight: 700;
  margin: 0 0 12px 0;
  letter-spacing: 2px;
}

.hero-subtitle {
  font-size: 16px;
  opacity: 0.85;
  margin: 0 0 24px 0;
  font-weight: 300;
}

.hero-meta {
  display: flex;
  gap: 24px;
  flex-wrap: wrap;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  opacity: 0.8;
  padding: 6px 14px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  backdrop-filter: blur(10px);
}

.hero-decoration {
  width: 200px;
  height: 160px;
  position: relative;
  flex-shrink: 0;
}

.deco-shape {
  position: absolute;
  border-radius: 50%;
}

.shape-1 {
  width: 120px;
  height: 120px;
  background: rgba(255, 255, 255, 0.04);
  top: 0;
  right: 20px;
}

.shape-2 {
  width: 70px;
  height: 70px;
  background: rgba(255, 255, 255, 0.07);
  top: 60px;
  right: -10px;
}

.shape-3 {
  width: 40px;
  height: 40px;
  background: rgba(64, 158, 255, 0.2);
  top: 20px;
  right: 80px;
}

/* ====== 统计卡片 ====== */
.stats-row {
  margin-bottom: 20px !important;
}

.stat-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  border-top: 3px solid;
  transition: all 0.3s ease;
  cursor: default;
  margin-bottom: 10px;
}

.stat-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
}

.stat-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-label {
  font-size: 13px;
  color: #909399;
  margin-bottom: 4px;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #303133;
}

/* ====== 通用卡片 ====== */
.section-card {
  border-radius: 12px;
  border: 1px solid #f0f0f0;
  margin-bottom: 20px;
}

.section-card :deep(.el-card__header) {
  border-bottom: 1px solid #f5f5f5;
  padding: 16px 20px;
}

.section-card :deep(.el-card__body) {
  padding: 8px 20px 20px;
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
  background: #409EFF;
  border-radius: 2px;
}

/* ====== 快捷功能 ====== */
.quick-card {
  text-align: center;
  padding: 24px 12px;
  cursor: pointer;
  border-radius: 12px;
  transition: all 0.3s ease;
  margin-bottom: 8px;
}

.quick-card:hover {
  background: #f8f9ff;
  transform: translateY(-3px);
}

.quick-icon-wrap {
  width: 56px;
  height: 56px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 12px;
}

.quick-title {
  display: block;
  font-size: 15px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 4px;
}

.quick-desc {
  display: block;
  font-size: 12px;
  color: #909399;
}

/* ====== 公告 ====== */
.notice-card {
  height: 100%;
}

.notice-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.notice-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 12px;
  border-radius: 8px;
  background: #fafafa;
  transition: background 0.2s;
}

.notice-item:hover {
  background: #f5f5f5;
}

.notice-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  margin-top: 6px;
  flex-shrink: 0;
}

.notice-content {
  flex: 1;
}

.notice-title {
  margin: 0 0 4px 0;
  font-size: 14px;
  color: #303133;
  line-height: 1.4;
}

.notice-time {
  font-size: 12px;
  color: #c0c4cc;
}

/* ====== 系统信息 ====== */
.tech-item {
  padding: 12px 16px;
  border-radius: 8px;
  background: #fafafa;
  margin-bottom: 8px;
}

.tech-label {
  display: block;
  font-size: 12px;
  color: #909399;
  margin-bottom: 4px;
}

.tech-value {
  font-size: 14px;
  color: #303133;
  font-weight: 600;
}

.status-ok {
  color: #67C23A;
}

/* ====== 响应式 ====== */
@media (max-width: 768px) {
  .hero-content {
    flex-direction: column;
    padding: 28px 24px;
  }

  .hero-title {
    font-size: 26px;
  }

  .hero-decoration {
    display: none;
  }

  .hero-meta {
    gap: 12px;
  }

  .stat-card {
    margin-bottom: 10px;
  }
}
</style>
