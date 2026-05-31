<template>
  <div class="app-container">
    <!-- 核心职能：展示往届优秀项目复盘与学长学姐进阶经验帖 -->
    <el-tabs v-model="activeTab" @tab-click="handleTabClick">
      <el-tab-pane label="往届项目复盘" name="retrospect">
        <el-table v-loading="loading" :data="retrospectList">
          <el-table-column label="项目名称" align="center" prop="projectName" :show-overflow-tooltip="true" />
          <el-table-column label="竞赛名称" align="center" prop="competitionName" width="160" />
          <el-table-column label="获奖级别" align="center" prop="awardLevel" width="100">
            <template #default="scope">
              <el-tag :type="scope.row.awardLevel === '国家级' ? 'danger' : 'warning'">
                {{ scope.row.awardLevel }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="团队负责人" align="center" prop="leaderName" width="100" />
          <el-table-column label="年份" align="center" prop="year" width="80" />
          <el-table-column label="操作" align="center" width="100">
            <template #default="scope">
              <el-button link type="primary" icon="View" @click="handleViewRetrospect(scope.row)">查看复盘</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="学长学姐经验帖" name="experience">
        <el-table v-loading="loading" :data="experienceList">
          <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
          <el-table-column label="作者" align="center" prop="author" width="100" />
          <el-table-column label="分类" align="center" prop="category" width="120">
            <template #default="scope">
              <el-tag size="small">{{ scope.row.category }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="发布时间" align="center" prop="createTime" width="180">
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="浏览" align="center" prop="viewCount" width="80" />
          <el-table-column label="操作" align="center" width="100">
            <template #default="scope">
              <el-button link type="primary" icon="View" @click="handleViewExperience(scope.row)">阅读全文</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
    </el-tabs>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script setup>
/* 核心职能：薪火相传（知识库）
 * 业务意图：传承竞赛经验，展示往届优秀项目复盘文档和学长学姐的进阶经验帖
 * Tab 1 - 往届项目复盘：展示获奖项目的完整复盘（选题思路、技术架构、答辩技巧等）
 * Tab 2 - 学长学姐经验帖：分类展示备赛心得、团队协作、时间管理等经验分享
 */

const { proxy } = getCurrentInstance()

const activeTab = ref('retrospect')
const loading = ref(false)
const retrospectList = ref([])
const experienceList = ref([])
const total = ref(0)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

function getList() {
  loading.value = true
  // TODO: 根据 activeTab 调用对应 API
  // if (activeTab.value === 'retrospect') { listRetrospect(queryParams.value).then(...) }
  // else { listExperience(queryParams.value).then(...) }
  loading.value = false
}

function handleTabClick() {
  queryParams.value.pageNum = 1
  getList()
}

function handleViewRetrospect(row) {
  // TODO: 打开项目复盘详情页
}

function handleViewExperience(row) {
  // TODO: 打开经验帖详情页
}

getList()
</script>

<style scoped>

</style>
