<template>
  <div>
    <el-popover ref="userNotifyPopover" placement="bottom-end" :width="340" trigger="manual" v-model:visible="notifyVisible" popper-class="user-notify-popover">
      <div class="notify-header">
        <span class="notify-title">个人通知</span>
        <span class="notify-mark-all" @click="markAllRead">全部已读</span>
      </div>
      <div v-if="notifyLoading" class="notify-loading">
        <el-icon class="is-loading"><Loading /></el-icon> 加载中...
      </div>
      <div v-else-if="notifyList.length === 0" class="notify-empty">
        <el-icon style="font-size:24px;display:block;margin-bottom:6px;"><Message /></el-icon>
        暂无通知
      </div>
      <div v-else class="notify-list-wrap">
        <div v-for="item in notifyList" :key="item.id" class="notify-item" :class="{ 'is-read': item.isRead === '1' }" @click="handleClickNotify(item)">
          <div class="notify-item-header">
            <el-tag size="small" :type="bizTypeTag(item.bizType)" class="notify-tag">{{ bizTypeLabel(item.bizType) }}</el-tag>
            <span class="notify-item-title">{{ item.title }}</span>
          </div>
          <div class="notify-item-content" v-if="item.content">{{ item.content }}</div>
          <div class="notify-item-date">{{ item.createTime }}</div>
        </div>
      </div>
      <template #reference>
        <div class="right-menu-item hover-effect notice-trigger" @mouseenter="onEnter" @mouseleave="onLeave">
          <svg-icon icon-class="message" />
          <span v-if="unreadCount > 0" class="notice-badge">{{ unreadCount > 99 ? '99+' : unreadCount }}</span>
        </div>
      </template>
    </el-popover>
  </div>
</template>

<script setup>
import { listNotifications, getUnreadCount, markAsRead, markAllAsRead } from '@/api/system/notification'

const userNotifyPopover = ref(null)
const notifyList = ref([])
const unreadCount = ref(0)
const notifyLoading = ref(false)
const notifyVisible = ref(false)
const notifyLeaveTimer = ref(null)

function loadNotifications() {
  notifyLoading.value = true
  listNotifications().then(res => {
    notifyList.value = res.data || []
    notifyLoading.value = false
  }).catch(() => {
    notifyLoading.value = false
  })
}

function loadUnreadCount() {
  getUnreadCount().then(res => {
    unreadCount.value = res.data?.count ?? 0
  }).catch(() => {})
}

onMounted(() => {
  loadUnreadCount()
})

function onEnter() {
  clearTimeout(notifyLeaveTimer.value)
  notifyVisible.value = true
  loadNotifications()
  nextTick(() => {
    const popper = userNotifyPopover.value?.popperRef?.contentRef
    if (popper && !popper._notifyBound) {
      popper._notifyBound = true
      popper.addEventListener('mouseenter', () => clearTimeout(notifyLeaveTimer.value))
      popper.addEventListener('mouseleave', () => {
        notifyLeaveTimer.value = setTimeout(() => { notifyVisible.value = false }, 100)
      })
    }
  })
}

function onLeave() {
  notifyLeaveTimer.value = setTimeout(() => { notifyVisible.value = false }, 150)
}

function handleClickNotify(item) {
  if (item.isRead === '0') {
    markAsRead(item.id).then(() => {
      unreadCount.value = Math.max(0, unreadCount.value - 1)
      item.isRead = '1'
    }).catch(() => {})
  }
}

function markAllRead() {
  markAllAsRead().then(() => {
    notifyList.value = notifyList.value.map(n => ({ ...n, isRead: '1' }))
    unreadCount.value = 0
  }).catch(() => {})
}

function bizTypeTag(bizType) {
  const map = { 'apply': 'primary', 'team': 'success', 'knowledge': 'warning', 'invitation': 'info', 'result': 'danger' }
  return map[bizType] || 'info'
}

function bizTypeLabel(bizType) {
  const map = { 'apply': '报名', 'team': '队伍', 'knowledge': '知识库', 'invitation': '邀请', 'result': '成绩' }
  return map[bizType] || bizType
}
</script>

<style lang="scss" scoped>
.notice-trigger {
  position: relative;
  .svg-icon { width: 1.2em; height: 1.2em; vertical-align: -0.2em; }
  .notice-badge {
    position: absolute;
    top: 6px;
    right: -5px;
    background: #f56c6c;
    color: #fff;
    border-radius: 10px;
    font-size: 10px;
    height: 16px;
    line-height: 16px;
    padding: 0 5px;
    min-width: 16px;
    text-align: center;
    white-space: nowrap;
    pointer-events: none;
  }
}
</style>

<style lang="scss">
.user-notify-popover { padding: 0 !important; }
.user-notify-popover .notify-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 14px;
  background: #f7f9fb;
  border-bottom: 1px solid #eee;
  font-size: 13px;
  font-weight: 600;
  color: #333;
}
.user-notify-popover .notify-mark-all {
  font-size: 12px;
  color: var(--el-color-primary);
  font-weight: normal;
  cursor: pointer;
}
.user-notify-popover .notify-mark-all:hover { color: #2b7cc1; }
.user-notify-popover .notify-loading,
.user-notify-popover .notify-empty {
  padding: 24px;
  text-align: center;
  color: #bbb;
  font-size: 12px;
}
.user-notify-popover .notify-list-wrap { max-height: 400px; overflow-y: auto; }
.user-notify-popover .notify-item {
  padding: 10px 14px;
  border-bottom: 1px solid #f5f5f5;
  cursor: pointer;
  transition: background 0.15s;
}
.user-notify-popover .notify-item:last-child { border-bottom: none; }
.user-notify-popover .notify-item:hover { background: #f7f9fb; }
.user-notify-popover .notify-item.is-read { opacity: 0.5; }
.user-notify-popover .notify-item-header {
  display: flex;
  align-items: center;
  gap: 8px;
}
.user-notify-popover .notify-tag { flex-shrink: 0; }
.user-notify-popover .notify-item-title {
  font-size: 13px;
  color: #333;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.user-notify-popover .notify-item-content {
  font-size: 12px;
  color: #909399;
  margin-top: 4px;
  padding-left: 36px;
  line-height: 1.5;
}
.user-notify-popover .notify-item-date {
  font-size: 11px;
  color: #bbb;
  text-align: right;
  padding-left: 36px;
  margin-top: 2px;
}
</style>
