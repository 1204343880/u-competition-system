<template>
  <div class="app-container">
    <!-- 核心职能：展示全校公开竞赛列表，支持按报名中/已结束状态过滤 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="竞赛名称" prop="compName">
        <el-input v-model="queryParams.compName" placeholder="请输入竞赛名称" clearable style="width: 240px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="竞赛状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择竞赛状态" clearable style="width: 160px">
          <el-option label="全部" value="" />
          <el-option label="报名中" value="0" />
          <el-option label="已结束" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList">
      <el-table-column label="竞赛名称" align="center" prop="compName" :show-overflow-tooltip="true" />
      <el-table-column label="竞赛类型" align="center" prop="compType" />
      <el-table-column label="报名截止" align="center" prop="enrollDeadline" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.enrollDeadline) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">
            {{ scope.row.status === '0' ? '报名中' : '已结束' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)">详情</el-button>
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
  </div>
</template>

<script setup>
/* 核心职能：竞赛大厅首页
 * 业务意图：为参赛学生提供全校公开竞赛的浏览入口
 * 支持按"报名中"和"已结束"两种状态快速筛选
 * 点击"详情"可查看竞赛的报名要求、时间安排等具体信息
 */

const { proxy } = getCurrentInstance()

const competitionList = ref([])
const loading = ref(false)
const showSearch = ref(true)
const total = ref(0)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    compName: undefined,
    status: undefined
  }
})

const { queryParams } = toRefs(data)

function getList() {
  loading.value = true
  // TODO: 调用竞赛大厅 API 获取公开竞赛列表
  // listHallCompetition(queryParams.value).then(response => {
  //   competitionList.value = response.rows
  //   total.value = response.total
  //   loading.value = false
  // })
  loading.value = false
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function handleDetail(row) {
  // TODO: 跳转到竞赛详情页或打开详情弹窗
}

getList()
</script>

<style scoped>

</style>
