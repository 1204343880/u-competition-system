<template>
  <div class="app-container">
    <el-table v-loading="loading" :data="raceList">
      <el-table-column label="竞赛名称" min-width="200" :show-overflow-tooltip="true">
        <template #default="scope">
          <el-link type="primary" @click="handleDetail(scope.row)">{{ scope.row.competitionName }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="类别" width="90">
        <template #default="scope">
          <dict-tag :options="competition_category" :value="scope.row.category" />
        </template>
      </el-table-column>
      <el-table-column label="报名时间" align="center" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.applyTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" width="90">
        <template #default="scope">
          <dict-tag :options="audit_status" :value="scope.row.auditStatus" />
        </template>
      </el-table-column>
      <el-table-column label="竞赛进度" align="center" width="90">
        <template #default="scope">
          <dict-tag :options="competition_status" :value="scope.row.compStatus" />
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

    <el-dialog :title="detailComp.competitionName" v-model="detailOpen" width="700px" append-to-body>
      <div v-if="detailComp.competitionId">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="竞赛名称" :span="2">{{ detailComp.competitionName }}</el-descriptions-item>
          <el-descriptions-item label="类别">
            <dict-tag :options="competition_category" :value="detailComp.category" />
          </el-descriptions-item>
          <el-descriptions-item label="状态">
            <dict-tag :options="competition_status" :value="detailComp.status" />
          </el-descriptions-item>
          <el-descriptions-item label="主办方">{{ detailComp.organizer }}</el-descriptions-item>
          <el-descriptions-item label="承办方">{{ detailComp.host || '-' }}</el-descriptions-item>
          <el-descriptions-item label="报名截止">{{ parseTime(detailComp.applyEndTime) }}</el-descriptions-item>
          <el-descriptions-item label="比赛时间">{{ parseTime(detailComp.startTime) }} ~ {{ parseTime(detailComp.endTime) }}</el-descriptions-item>
          <el-descriptions-item label="竞赛详情" :span="2">
            <div class="rich-content" v-html="detailComp.description || '暂无详情'"></div>
          </el-descriptions-item>
        </el-descriptions>
      </div>
      <template #footer>
        <el-button @click="detailOpen = false">关 闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>

const { proxy } = getCurrentInstance()
const { competition_status, competition_category, audit_status } = useDict('competition_status', 'competition_category', 'audit_status')

const raceList = ref([])
const loading = ref(false)
const total = ref(0)
const detailOpen = ref(false)
const detailComp = ref({})

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

import { listMyApplies } from '@/api/competition/hall'
import { getCompetition } from '@/api/competition/hall'

function getList() {
  loading.value = true
  listMyApplies().then(response => {
    raceList.value = response.data || []
    total.value = raceList.value.length
    loading.value = false
  })
}

function handleDetail(row) {
  getCompetition(row.competitionId).then(response => {
    detailComp.value = response.data
    detailOpen.value = true
  })
}

getList()
</script>

<style scoped>
.rich-content {
  max-height: 300px;
  overflow-y: auto;
  line-height: 1.8;
}
.rich-content :deep(p) {
  margin: 4px 0;
}
</style>
