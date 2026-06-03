<template>
   <div class="profile-page">
      <!-- 顶部个人名片区 -->
      <div class="profile-card">
         <div class="banner"></div>
         <div class="card-body">
            <div class="avatar-wrap"><userAvatar /></div>
            <div class="info-section">
               <div class="info-left">
                  <div class="nickname">{{ state.user.nickName }}</div>
                  <div class="meta">
                     <template v-if="isStudent">
                        <span>{{ state.user.studentNo || '未填写学号' }}</span>
                        <el-divider direction="vertical" />
                        <span>{{ state.user.grade || '未填写年级' }}</span>
                        <el-divider direction="vertical" />
                     </template>
                     <span>{{ state.user.dept ? state.user.dept.deptName : '未填写部门' }}</span>
                  </div>
               </div>
               <div class="info-right">
                  <el-button type="primary" plain round icon="Edit" size="small" @click="selectedTab = 'userinfo'">编辑资料</el-button>
               </div>
            </div>
         </div>
      </div>

      <!-- 内容区 -->
      <div class="content-card">
         <el-tabs v-model="selectedTab">
            <el-tab-pane v-if="isStudent" label="个人概览" name="overview">
               <div class="block">
                  <h4 class="block-title">技能标签</h4>
                  <div class="skill-tags">
                     <el-tag v-for="(skill, idx) in skillList" :key="skill" class="skill-tag" :class="'tag-' + (idx % 4)" size="default">{{ skill }}</el-tag>
                     <span v-if="skillList.length === 0" class="empty-hint">暂未填写，点击编辑资料添加</span>
                  </div>
               </div>
               <div class="block">
                  <h4 class="block-title">联系方式</h4>
                  <div class="contact-row">
                     <div class="contact-item">
                        <svg-icon icon-class="phone" />
                        <span>{{ state.user.phonenumber }}</span>
                     </div>
                     <div class="contact-item">
                        <svg-icon icon-class="email" />
                        <span>{{ state.user.email }}</span>
                     </div>
                     <div class="contact-item">
                        <svg-icon icon-class="peoples" />
                        <span>{{ state.roleGroup }}</span>
                     </div>
                  </div>
               </div>
            </el-tab-pane>

            <el-tab-pane v-if="isStudent" label="竞赛历程" name="history">
               <el-timeline>
                  <el-timeline-item v-for="item in competitions" :key="item.id" :timestamp="item.date" placement="top">
                     <el-card shadow="hover" class="timeline-card">
                        <div class="timeline-header">
                           <span class="comp-name">{{ item.name }}</span>
                           <el-tag :type="item.award.includes('一等') || item.award.includes('二等') ? 'danger' : 'warning'" size="small">{{ item.award }}</el-tag>
                        </div>
                        <div class="timeline-role">担任角色：{{ item.role }}</div>
                     </el-card>
                  </el-timeline-item>
               </el-timeline>
            </el-tab-pane>

            <el-tab-pane label="基本资料" name="userinfo">
               <userInfo :user="state.user" />
            </el-tab-pane>

            <el-tab-pane label="修改密码" name="resetPwd">
               <resetPwd />
            </el-tab-pane>
         </el-tabs>
      </div>
   </div>
</template>

<script setup name="Profile">
import userAvatar from "./userAvatar"
import userInfo from "./userInfo"
import resetPwd from "./resetPwd"
import { getUserProfile } from "@/api/system/user"

const route = useRoute()
const selectedTab = ref("userinfo")
const state = reactive({
  user: {},
  roleGroup: {},
  postGroup: {}
})

const isStudent = computed(() => {
  const roles = state.user?.roles
  return Array.isArray(roles) && roles.some(role => role.roleKey === 'student')
})

const skillList = computed(() => {
  const tags = state.user?.skillTags
  return tags ? String(tags).split(',').map(s => s.trim()).filter(Boolean) : []
})

const competitions = ref([
  { id: 1, date: '2025-10', name: '第十届蓝桥杯', award: '省赛一等奖', role: '队长' },
  { id: 2, date: '2025-05', name: '全国大学生计算机设计大赛', award: '国赛三等奖', role: '核心开发' }
])

function getUser() {
  getUserProfile().then(response => {
    state.user = response.data || {}
    state.roleGroup = response.roleGroup || ''
    state.postGroup = response.postGroup || ''
    if (isStudent.value) {
      selectedTab.value = 'overview'
    }
  }).catch(() => {})
}

onMounted(() => {
  const activeTab = route.params && route.params.activeTab
  if (activeTab) {
    selectedTab.value = activeTab
  }
  getUser()
})
</script>

<style scoped>
.profile-page {
  min-height: calc(100vh - 84px);
  background: #f5f7fa;
  padding: 24px;
}
.profile-card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  overflow: hidden;
}
.banner {
  height: 120px;
  background: linear-gradient(135deg, #4f6ef7 0%, #7e93fb 50%, #a0b4ff 100%);
}
.card-body {
  padding: 0 24px 24px;
  position: relative;
}
.avatar-wrap {
  margin-top: -40px;
  margin-bottom: 12px;
}
.info-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}
.nickname {
  font-size: 22px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 6px;
}
.meta {
  font-size: 13px;
  color: #909399;
  display: flex;
  align-items: center;
}
.content-card {
  margin-top: 16px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  padding: 20px 24px;
}
.block {
  margin-bottom: 24px;
}
.block-title {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 12px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid #ebeef5;
}
.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.skill-tag {
  border-radius: 20px;
  padding: 0 16px;
  height: 32px;
  line-height: 30px;
  font-size: 13px;
  border: none;
}
.tag-0 { background: #ecf5ff; color: #4f6ef7; }
.tag-1 { background: #f0f9eb; color: #67c23a; }
.tag-2 { background: #fdf6ec; color: #e6a23c; }
.tag-3 { background: #fef0f0; color: #f56c6c; }
.empty-hint {
  font-size: 13px;
  color: #c0c4cc;
}
.contact-row {
  display: flex;
  gap: 32px;
  flex-wrap: wrap;
}
.contact-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: #606266;
}
.timeline-card {
  border-radius: 8px;
}
.timeline-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}
.comp-name {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
}
.timeline-role {
  font-size: 13px;
  color: #909399;
}
</style>
