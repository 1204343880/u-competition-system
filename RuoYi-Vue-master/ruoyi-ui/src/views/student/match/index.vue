<template>
  <div class="app-container">
    <!-- 核心职能：学生自由组队大厅，支持通过Skill标签双向检索 -->
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card shadow="hover">
          <template #header>
            <span>技能标签筛选</span>
          </template>
          <SkillSelector v-model="selectedSkills" />
          <el-divider />
          <el-button type="primary" icon="Search" @click="handleSearch">匹配检索</el-button>
          <el-button icon="Refresh" @click="resetSkills">重置</el-button>
        </el-card>
      </el-col>
      <el-col :span="16">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>队伍列表</span>
              <el-button type="primary" plain icon="Plus" @click="handleCreate">创建队伍</el-button>
            </div>
          </template>
          <el-table v-loading="loading" :data="teamList">
            <el-table-column label="队伍名称" align="center" prop="teamName" :show-overflow-tooltip="true" />
            <el-table-column label="队长" align="center" prop="leaderName" width="100" />
            <el-table-column label="技能标签" align="center" prop="skills" :show-overflow-tooltip="true">
              <template #default="scope">
                <el-tag v-for="tag in scope.row.skills" :key="tag" size="small" style="margin: 2px">{{ tag }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="人数" align="center" width="80">
              <template #default="scope">
                <span>{{ scope.row.currentMembers }}/{{ scope.row.maxMembers }}</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" align="center" width="120">
              <template #default="scope">
                <el-button link type="primary" icon="View" @click="handleJoin(scope.row)">申请加入</el-button>
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
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
/* 核心职能：组队匹配中心
 * 业务意图：为参赛学生提供自由组队平台
 * 支持通过"路演/PPT/编程/建模/设计"等Skill标签进行双向检索匹配
 * 学生可创建新队伍或申请加入已有队伍
 */

import SkillSelector from '@/components/SkillSelector/index.vue'

const { proxy } = getCurrentInstance()

const teamList = ref([])
const loading = ref(false)
const total = ref(0)

const selectedSkills = ref([])

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

function getList() {
  loading.value = true
  // TODO: 调用组队匹配 API，传入 selectedSkills 进行筛选
  // listTeam({ ...queryParams.value, skills: selectedSkills.value }).then(...)
  loading.value = false
}

function handleSearch() {
  queryParams.value.pageNum = 1
  getList()
}

function resetSkills() {
  selectedSkills.value = []
  handleSearch()
}

function handleCreate() {
  // TODO: 打开创建队伍对话框
}

function handleJoin(row) {
  // TODO: 申请加入队伍逻辑
}

getList()
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
