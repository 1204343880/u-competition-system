<template>
  <div class="app-container">
    <el-row :gutter="10" style="margin-bottom: 16px">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Bell" size="small" @click="getList">刷新</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Check" size="small" @click="handleMarkAllRead" :disabled="list.length === 0">全部已读</el-button>
      </el-col>
    </el-row>

    <el-timeline v-if="list.length > 0">
      <el-timeline-item
        v-for="item in list"
        :key="item.id"
        :timestamp="parseTime(item.createTime)"
        placement="top"
        :color="item.isRead === '0' ? '#e6a23c' : '#909399'"
      >
        <el-card shadow="hover" :class="{ 'unread-card': item.isRead === '0' }">
          <template #header>
            <div style="display: flex; justify-content: space-between; align-items: center">
              <div>
                <el-tag v-if="item.isRead === '0'" type="warning" size="small">未读</el-tag>
                <el-tag v-else type="info" size="small">已读</el-tag>
                <strong style="margin-left: 8px">{{ item.title }}</strong>
              </div>
              <div>
                <el-button v-if="item.isRead === '0'" link type="primary" size="small" @click="handleRead(item)">标为已读</el-button>
                <el-button link type="danger" size="small" @click="handleDelete(item)">删除</el-button>
              </div>
            </div>
          </template>
          <div>{{ item.content }}</div>
        </el-card>
      </el-timeline-item>
    </el-timeline>
    <el-empty v-else description="暂无通知消息" />
  </div>
</template>

<script setup>
import { listNotifications, markAsRead, markAllAsRead, deleteNotifications } from '@/api/notification'

const { proxy } = getCurrentInstance()

const list = ref([])

function getList() {
  listNotifications().then(res => {
    list.value = res.data || []
  })
}

function handleRead(item) {
  markAsRead(item.id).then(() => {
    item.isRead = '1'
    proxy.$modal.msgSuccess('已标为已读')
  })
}

function handleMarkAllRead() {
  markAllAsRead().then(() => {
    list.value.forEach(item => { item.isRead = '1' })
    proxy.$modal.msgSuccess('全部已读')
  })
}

function handleDelete(item) {
  proxy.$modal.confirm('确认删除该通知？').then(() => {
    return deleteNotifications(item.id)
  }).then(() => {
    proxy.$modal.msgSuccess('已删除')
    getList()
  })
}

getList()
</script>

<style scoped>
.unread-card {
  border-left: 3px solid #e6a23c;
}
</style>
