<template>
   <div class="profile-page">
      <!-- 顶部个人名片区 -->
      <div class="profile-card">
         <div class="banner">
            <span>PERSONAL SPACE</span>
            <strong>我的成长档案</strong>
            <p>整理技能、经历与竞赛足迹，让每一次参与都有迹可循。</p>
         </div>
         <div class="card-body">
            <div class="avatar-wrap"><userAvatar /></div>
            <div class="info-section">
               <div class="info-left">
                  <div class="nickname">{{ state.user.nickName }}</div>
                   <div class="meta">
                      <template v-if="isStudent">
                         <span>学号：{{ state.user.studentNo || '未填写' }}</span>
                         <el-divider direction="vertical" />
                         <span>年级：{{ state.user.grade || '未填写' }}</span>
                         <el-divider direction="vertical" />
                         <span>学院：{{ state.user.dept?.parentName || '未填写' }}</span>
                         <el-divider direction="vertical" />
                         <span>专业：{{ state.user.dept?.deptName || '未填写' }}</span>
                      </template>
                      <span v-else>{{ state.user.dept ? state.user.dept.deptName : '未填写部门' }}</span>
                   </div>
                   <div class="profile-completion" :class="{ complete: profileCompletion === 100 }">
                      <span>资料完整度 {{ profileCompletion }}%</span>
                      <span v-if="missingProfileFields.length">还缺：{{ missingProfileSummary }}</span>
                      <span v-else>资料已完善</span>
                      <button v-if="missingProfileFields.length" type="button" @click="selectedTab = 'userinfo'">去完善</button>
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
                         <span>{{ state.user.phonenumber || '未填写手机' }}</span>
                      </div>
                      <div class="contact-item">
                         <svg-icon icon-class="email" />
                         <span>{{ state.user.email || '未填写邮箱' }}</span>
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

const requiredProfileFields = computed(() => {
  const user = state.user || {}
  const fields = [
    { label: '手机', value: user.phonenumber },
    { label: '邮箱', value: user.email }
  ]
  if (isStudent.value) {
    fields.unshift(
      { label: '学号', value: user.studentNo },
      { label: '年级', value: user.grade },
      { label: '学院', value: user.dept?.parentName },
      { label: '专业', value: user.dept?.deptName }
    )
    fields.push({ label: '技能标签', value: user.skillTags })
  } else {
    fields.unshift({ label: '部门', value: user.dept?.deptName })
  }
  return fields
})

const missingProfileFields = computed(() => requiredProfileFields.value.filter(item => !String(item.value || '').trim()))
const profileCompletion = computed(() => {
  const total = requiredProfileFields.value.length
  return total ? Math.round((total - missingProfileFields.value.length) / total * 100) : 0
})
const missingProfileSummary = computed(() => {
  const labels = missingProfileFields.value.map(item => item.label)
  return labels.length > 3 ? `${labels.slice(0, 3).join('、')}等${labels.length}项` : labels.join('、')
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
    const requestedTab = String(route.params?.activeTab || '')
    const allowedTabs = isStudent.value
      ? ['overview', 'history', 'userinfo', 'resetPwd']
      : ['userinfo', 'resetPwd']
    selectedTab.value = allowedTabs.includes(requestedTab)
      ? requestedTab
      : (isStudent.value ? 'overview' : 'userinfo')
  }).catch(() => {})
}

onMounted(() => {
  getUser()
})
</script>

<style scoped>
.profile-page {
  min-height: calc(100vh - 84px);
  max-width: 1240px;
  margin: 0 auto;
  background: transparent;
  padding: 0;
  color: var(--student-ink, #25272b);
}
.profile-card {
  background: #fff;
  border-radius: 18px;
  box-shadow: var(--student-shadow, 0 1px 2px rgba(41,45,52,.04));
  overflow: hidden;
}
.banner {
  position: relative;
  height: 156px;
  padding: 30px 40px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;
  background: linear-gradient(135deg, #f8fbff 0%, #edf4ff 100%);
}
.banner::after {
  content: '';
  position: absolute;
  width: 300px;
  height: 300px;
  right: -74px;
  bottom: -174px;
  border-radius: 50%;
  background: rgba(26, 115, 232, .07);
}
.banner span { margin-bottom: 9px; color: #6f819d; font-size: 11px; font-weight: 650; letter-spacing: .14em; }
.banner strong { color: #26374f; font-size: 27px; font-weight: 650; letter-spacing: -.03em; }
.banner p { margin: 9px 0 0; color: #6b7584; font-size: 13px; }
.banner > * { position: relative; z-index: 1; }
.card-body {
  display: grid;
  grid-template-columns: 130px minmax(0, 1fr);
  align-items: center;
  column-gap: 22px;
  padding: 0 32px 24px;
  position: relative;
}
.avatar-wrap {
  margin-top: -38px;
  margin-bottom: 0;
  width: 130px;
  height: 130px;
  display: grid;
  place-items: center;
  padding: 5px;
  border-radius: 50%;
  overflow: hidden;
  box-sizing: border-box;
  background: #fff;
  box-shadow: 0 4px 14px rgba(44,52,64,.08);
}
.info-section {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
  min-width: 0;
}
.info-left { min-width: 0; }
.nickname {
  font-size: 23px;
  font-weight: 650;
  color: var(--student-ink, #25272b);
  margin-bottom: 6px;
}
.meta {
  font-size: 13px;
  color: var(--student-muted, #73777f);
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 6px 0;
}
.profile-completion {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 7px;
  margin-top: 10px;
  color: #8a6a34;
  font-size: 12px;
}
.profile-completion > span:first-child { color: #53657d; font-weight: 600; }
.profile-completion.complete { color: #25835c; }
.profile-completion button {
  padding: 0;
  color: #1a73e8;
  border: 0;
  background: transparent;
  font: inherit;
  cursor: pointer;
}
.profile-completion button:hover { text-decoration: underline; }
.content-card {
  margin-top: 18px;
  background: #fff;
  border-radius: 16px;
  box-shadow: var(--student-shadow, 0 1px 2px rgba(41,45,52,.04));
  padding: 18px 28px 22px;
}
.content-card :deep(.el-tabs__item:focus),
.content-card :deep(.el-tabs__item:focus-visible) { outline: none; box-shadow: none; }
.block {
  margin-bottom: 18px;
}
.block:last-child { margin-bottom: 0; }
.block-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--student-ink, #25272b);
  margin: 0 0 12px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid var(--student-line, rgba(31,35,41,.07));
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
  color: #565b63;
}
.timeline-card {
  border-radius: 12px;
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
  color: var(--student-ink, #25272b);
}
.timeline-role {
  font-size: 13px;
  color: var(--student-muted, #73777f);
}

@media (max-width: 720px) {
  .banner { height: 150px; padding: 28px 24px; }
  .banner strong { font-size: 24px; }
  .banner p { max-width: 78%; }
  .card-body { grid-template-columns: 1fr; gap: 10px; padding: 0 22px 24px; }
  .content-card { padding: 18px; }
  .info-section { gap: 14px; }
}
</style>
