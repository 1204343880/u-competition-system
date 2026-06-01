<template>
  <div class="profile-page">
    <!-- 顶部个人名片区 -->
    <div class="profile-card">
      <div class="banner"></div>
      <div class="card-body">
        <div class="avatar-wrap">
          <el-avatar :size="80" :src="userInfo.avatar" />
        </div>
        <div class="info-section">
          <div class="info-left">
            <div class="nickname">{{ userInfo.nickname }}</div>
            <div class="meta">
              <span>{{ userInfo.studentId }}</span>
              <el-divider direction="vertical" />
              <span>{{ userInfo.grade }}</span>
              <el-divider direction="vertical" />
              <span>{{ userInfo.major }}</span>
            </div>
          </div>
          <div class="info-right">
            <el-button type="primary" plain round icon="Edit" size="small">编辑资料</el-button>
          </div>
        </div>
      </div>
    </div>

    <!-- 内容区 -->
    <div class="content-card">
      <el-tabs v-model="activeTab">
        <el-tab-pane label="个人概览" name="overview">
          <!-- 技能标签 -->
          <div class="block">
            <h4 class="block-title">技能标签</h4>
            <div class="skill-tags">
              <el-tag
                v-for="skill in userInfo.skills"
                :key="skill"
                class="skill-tag"
                size="default"
              >{{ skill }}</el-tag>
            </div>
          </div>
          <!-- 个人简介 -->
          <div class="block">
            <h4 class="block-title">个人简介</h4>
            <p class="bio">{{ userInfo.bio }}</p>
          </div>
        </el-tab-pane>

        <el-tab-pane label="竞赛历程" name="history">
          <el-timeline>
            <el-timeline-item
              v-for="item in competitions"
              :key="item.id"
              :timestamp="item.date"
              placement="top"
            >
              <el-card shadow="hover" class="timeline-card">
                <div class="timeline-header">
                  <span class="comp-name">{{ item.name }}</span>
                  <el-tag
                    :type="item.award.includes('一等') || item.award.includes('二等') ? 'danger' : 'warning'"
                    size="small"
                  >{{ item.award }}</el-tag>
                </div>
                <div class="timeline-role">担任角色：{{ item.role }}</div>
              </el-card>
            </el-timeline-item>
          </el-timeline>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup>
const activeTab = ref('overview')

const userInfo = ref({
  avatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
  nickname: 'student01',
  studentId: '2206161033',
  grade: '2022级',
  major: '计算机科学与技术',
  skills: ['Java', 'Vue', '产品设计', 'PPT制作'],
  bio: '热爱编程，寻找能一起打大创和互联网+的后端大佬。'
})

const competitions = ref([
  { id: 1, date: '2025-10', name: '第十届蓝桥杯', award: '省赛一等奖', role: '队长' },
  { id: 2, date: '2025-05', name: '全国大学生计算机设计大赛', award: '国赛三等奖', role: '核心开发' }
])
</script>

<style scoped>
.profile-page {
  min-height: 100vh;
  background: #f5f7fa;
  padding: 24px;
}

/* 名片区 */
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

.avatar-wrap .el-avatar {
  border: 4px solid #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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

/* 内容卡片 */
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

.skill-tag:nth-child(1) { background: #ecf5ff; color: #4f6ef7; }
.skill-tag:nth-child(2) { background: #f0f9eb; color: #67c23a; }
.skill-tag:nth-child(3) { background: #fdf6ec; color: #e6a23c; }
.skill-tag:nth-child(4) { background: #fef0f0; color: #f56c6c; }

.bio {
  font-size: 14px;
  color: #606266;
  line-height: 1.8;
}

/* 时间线 */
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
