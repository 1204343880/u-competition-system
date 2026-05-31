<template>
  <div class="app-container">
    <!-- 核心职能：学生个人信息完善与校验（学号、学院、年级、联系方式） -->
    <el-card shadow="hover">
      <template #header>
        <div class="card-header">
          <span>基本信息</span>
          <el-button type="primary" icon="Edit" @click="handleEdit">编辑信息</el-button>
        </div>
      </template>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="学号">{{ form.studentNo || '-' }}</el-descriptions-item>
        <el-descriptions-item label="姓名">{{ form.nickName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="所属学院">{{ form.collegeName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="专业">{{ form.majorName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="年级">{{ form.grade || '-' }}</el-descriptions-item>
        <el-descriptions-item label="手机号码">{{ form.phonenumber || '-' }}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{ form.email || '-' }}</el-descriptions-item>
        <el-descriptions-item label="账号状态">
          <el-tag :type="form.status === '0' ? 'success' : 'danger'">
            {{ form.status === '0' ? '正常' : '停用' }}
          </el-tag>
        </el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
</template>

<script setup>
/* 核心职能：我的信息（我的赛程子页面）
 * 业务意图：展示和校验参赛学生的个人信息
 * 展示字段包括学号、所属学院、年级、联系方式（手机/邮箱）
 * 学生可编辑完善个人信息，前端校验手机号格式和邮箱格式
 */

const { proxy } = getCurrentInstance()

const form = ref({
  studentNo: '',
  nickName: '',
  collegeName: '',
  majorName: '',
  grade: '',
  phonenumber: '',
  email: '',
  status: '0'
})

function getInfo() {
  // TODO: 调用 getUserProfile API 获取当前登录用户信息
  // getUserProfile().then(response => {
  //   form.value = response.data
  // })
}

function handleEdit() {
  // TODO: 打开个人信息编辑弹窗，提交后刷新
  // 前端校验规则：
  //   学号：必填，格式为数字
  //   手机号码：必填，正则 /^1[3-9]\d{9}$/
  //   邮箱：可选，正则 /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
}

getInfo()
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
