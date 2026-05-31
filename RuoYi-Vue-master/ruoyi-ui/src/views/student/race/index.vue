<template>
  <div class="app-container">
    <!-- 核心职能：已报名赛程追踪，支持查看竞赛进度与上传报名凭证截图 -->
    <el-table v-loading="loading" :data="raceList">
      <el-table-column label="竞赛名称" align="center" prop="compName" :show-overflow-tooltip="true" />
      <el-table-column label="报名时间" align="center" prop="applyTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.applyTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="auditStatus" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.auditStatus === '0'" type="info">待审核</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '1'" type="success">通过</el-tag>
          <el-tag v-else-if="scope.row.auditStatus === '2'" type="danger">拒绝</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="竞赛进度" align="center" prop="progress" width="120">
        <template #default="scope">
          <el-tag :type="scope.row.progress === '2' ? 'info' : 'warning'">
            {{ scope.row.progress === '0' ? '报名中' : scope.row.progress === '1' ? '进行中' : '已结束' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="报名凭证" align="center" width="120">
        <template #default="scope">
          <el-button v-if="scope.row.voucherUrl" link type="primary" icon="Picture" @click="handlePreview(scope.row)">查看凭证</el-button>
          <el-upload
            v-else
            :show-file-list="false"
            :http-request="(option) => handleUpload(option, scope.row)"
            accept="image/*"
          >
            <el-button link type="primary" icon="Upload">上传凭证</el-button>
          </el-upload>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="100">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)">查看详情</el-button>
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
/* 核心职能：我的竞赛（我的赛程子页面）
 * 业务意图：展示当前学生已报名的所有竞赛赛程
 * 包含竞赛名称、报名时间、审核状态、竞赛进度等关键追踪信息
 * 支持上传报名凭证截图（如缴费截图、官网报名成功截图）
 */

const { proxy } = getCurrentInstance()

const raceList = ref([])
const loading = ref(false)
const total = ref(0)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

function getList() {
  loading.value = true
  // TODO: 调用我的竞赛 API
  // listMyRace(queryParams.value).then(response => {
  //   raceList.value = response.rows
  //   total.value = response.total
  //   loading.value = false
  // })
  loading.value = false
}

function handleDetail(row) {
  // TODO: 查看竞赛详情
}

function handlePreview(row) {
  // TODO: 预览已上传的凭证截图
}

function handleUpload(option, row) {
  // TODO: 上传报名凭证截图到服务器
  // uploadVoucher(row.id, option.file).then(() => { getList() })
}

getList()
</script>

<style scoped>

</style>
