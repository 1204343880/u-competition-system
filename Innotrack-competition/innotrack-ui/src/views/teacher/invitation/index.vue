<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-change="handleTabChange">
      <el-tab-pane label="待处理邀请" name="pending">
        <el-table v-loading="loading" :data="pendingList">
          <el-table-column label="队名" align="center" prop="teamName" width="140" />
          <el-table-column label="竞赛名称" align="center" prop="competitionName" :show-overflow-tooltip="true" />
          <el-table-column label="邀请人" align="center" prop="studentName" width="100" />
          <el-table-column label="邀请时间" align="center" prop="createTime" width="160">
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="220">
            <template #default="scope">
              <el-button link type="success" icon="Select" @click="handleAccept(scope.row)">接受</el-button>
              <el-button link type="danger" icon="Close" @click="handleReject(scope.row)">拒绝</el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-empty v-if="!loading && pendingList.length === 0" description="暂无待处理邀请" />
      </el-tab-pane>

      <el-tab-pane label="处理历史" name="history">
        <el-table v-loading="loading" :data="historyList">
          <el-table-column label="队名" align="center" prop="teamName" width="140" />
          <el-table-column label="竞赛名称" align="center" prop="competitionName" :show-overflow-tooltip="true" />
          <el-table-column label="邀请人" align="center" prop="studentName" width="100" />
          <el-table-column label="状态" align="center" prop="status" width="100">
            <template #default="scope">
              <el-tag v-if="scope.row.status === '1'" type="success">已接受</el-tag>
              <el-tag v-else-if="scope.row.status === '2'" type="danger">已拒绝</el-tag>
              <el-tag v-else-if="scope.row.status === '3'" type="info">已撤销</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="处理时间" align="center" prop="updateTime" width="160">
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="回复" align="center" prop="replyMessage" width="160" :show-overflow-tooltip="true" />
        </el-table>
        <el-empty v-if="!loading && historyList.length === 0" description="暂无处理历史" />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup>
import { listPendingInvitations, listInvitationHistory, acceptInvitation, rejectInvitation } from '@/api/competition/invitation'

const { proxy } = getCurrentInstance()

const activeTab = ref('pending')
const loading = ref(false)
const pendingList = ref([])
const historyList = ref([])

function loadPending() {
  loading.value = true
  listPendingInvitations().then(res => {
    pendingList.value = res.data
    loading.value = false
  }).catch(() => { loading.value = false })
}

function loadHistory() {
  loading.value = true
  listInvitationHistory().then(res => {
    historyList.value = res.data
    loading.value = false
  }).catch(() => { loading.value = false })
}

function handleTabChange() {
  if (activeTab.value === 'pending') loadPending()
  else loadHistory()
}

function handleAccept(row) {
  proxy.$modal.confirm('确认接受该邀请？接受后将作为指导教师加入该队伍。').then(() => {
    return acceptInvitation(row.invitationId, { replyMessage: '已接受' })
  }).then(() => {
    proxy.$modal.msgSuccess('已接受邀请')
    loadPending()
  })
}

function handleReject(row) {
  proxy.$prompt('拒绝理由（选填）', '拒绝邀请', {
    confirmButtonText: '确定拒绝',
    cancelButtonText: '取消',
    inputPlaceholder: '请输入拒绝理由'
  }).then(({ value }) => {
    return rejectInvitation(row.invitationId, { replyMessage: value || '暂时无法指导' })
  }).then(() => {
    proxy.$modal.msgSuccess('已拒绝')
    loadPending()
  }).catch(() => {})
}

loadPending()
</script>
