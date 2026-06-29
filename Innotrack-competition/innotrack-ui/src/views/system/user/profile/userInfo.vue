<template>
   <el-form ref="userRef" :model="form" :rules="rules" label-width="80px">
      <el-form-item label="用户昵称" prop="nickName">
         <el-input v-model="form.nickName" maxlength="30" />
      </el-form-item>
      <el-form-item label="手机号码" prop="phonenumber">
         <el-input v-model="form.phonenumber" maxlength="11" />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
         <el-input v-model="form.email" maxlength="50" />
      </el-form-item>
      <el-form-item label="性别">
         <el-radio-group v-model="form.sex">
            <el-radio value="0">男</el-radio>
            <el-radio value="1">女</el-radio>
         </el-radio-group>
      </el-form-item>
      <!-- 竞赛系统扩展：参赛学生专属字段，仅学生角色可见 -->
      <template v-if="isStudent">
         <el-divider content-position="left">参赛学生信息</el-divider>
         <el-form-item label="学号" prop="studentNo">
            <el-input v-model="form.studentNo" maxlength="20" placeholder="请输入学号" />
         </el-form-item>
          <el-form-item label="年级" prop="grade">
             <el-input v-model="form.grade" maxlength="10" placeholder="如：2024级" />
          </el-form-item>
          <el-form-item label="学院" prop="collegeId">
             <el-select v-model="form.collegeId" placeholder="请选择学院" style="width:100%" @change="handleCollegeChange">
                <el-option v-for="college in colleges" :key="college.collegeId" :label="college.collegeName" :value="college.collegeId" />
             </el-select>
          </el-form-item>
          <el-form-item label="专业" prop="deptId">
             <el-select v-model="form.deptId" placeholder="请选择专业" style="width:100%" :disabled="!form.collegeId">
                <el-option v-for="major in availableMajors" :key="major.deptId" :label="major.deptName" :value="major.deptId" />
             </el-select>
          </el-form-item>
          <el-form-item label="技能标签" prop="skillTags">
             <SkillSelector v-model="selectedSkillIds" />
          </el-form-item>
      </template>
      <el-form-item>
      <el-button type="primary" @click="submit">保存</el-button>
      <el-button type="danger" @click="close">关闭</el-button>
      </el-form-item>
   </el-form>
</template>

<script setup>
import { ref, computed, watch, nextTick, getCurrentInstance } from 'vue'
import { updateUserProfile } from "@/api/system/user"
import { getRegisterDepartments } from '@/api/login'
import SkillSelector from '@/components/SkillSelector/index.vue'

const props = defineProps({
  user: {
    type: Object
  }
})

const { proxy } = getCurrentInstance()

const form = ref({})
const selectedSkillIds = ref([])
const colleges = ref([])
const availableMajors = computed(() => {
  const college = colleges.value.find(item => item.collegeId === form.value.collegeId)
  return college?.majors || []
})
const rules = ref({
  nickName: [{ required: true, message: "用户昵称不能为空", trigger: "blur" }],
  email: [{ required: true, message: "邮箱地址不能为空", trigger: "blur" }, { type: "email", message: "请输入正确的邮箱地址", trigger: ["blur", "change"] }],
  phonenumber: [{ required: true, message: "手机号码不能为空", trigger: "blur" }, { pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/, message: "请输入正确的手机号码", trigger: "blur" }],
  studentNo: [{ required: true, message: '学号不能为空', trigger: 'blur' }, { pattern: /^[A-Za-z0-9]{4,20}$/, message: '学号须为4到20位字母或数字', trigger: 'blur' }],
  grade: [{ required: true, message: '年级不能为空', trigger: 'blur' }],
  collegeId: [{ required: true, message: '请选择学院', trigger: 'change' }],
  deptId: [{ required: true, message: '请选择专业', trigger: 'change' }],
})

const isStudent = computed(() => {
  return props.user?.roles?.some(role => role.roleKey === 'student')
})

// 技能名称 ↔ ID 互转（与 SkillSelector 内的数据保持一致）
const nameToId = {
  '路演答辩': 101, '项目PM': 102, '市场调研': 103,
  'BP撰写': 201, '财务测算': 202, '专利/论文撰写': 203,
  'PPT美工': 301, 'UI/UX设计': 302, '海报/视频剪辑': 303,
  '后端架构': 401, '前端开发': 402, '算法模型': 403, '硬件单片机': 404
}
const idToName = Object.fromEntries(Object.entries(nameToId).map(([k, v]) => [v, k]))

function tagsToIds(str) {
  if (!str) return []
  return String(str).split(',').map(s => s.trim()).filter(Boolean).map(n => nameToId[n]).filter(Boolean)
}
function idsToTags(ids) {
  if (!ids || !ids.length) return ''
  return ids.map(id => idToName[id]).filter(Boolean).join(',')
}

// SkillSelector 变更 → 回写 form.skillTags
watch(selectedSkillIds, (ids) => {
  const tags = idsToTags(ids)
  if (form.value && tags !== form.value.skillTags) {
    form.value.skillTags = tags
  }
}, { deep: true })

/** 提交按钮 */
function submit() {
  proxy.$refs.userRef.validate(valid => {
    if (valid) {
      const { collegeId, ...payload } = form.value
      updateUserProfile(payload).then(() => {
        proxy.$modal.msgSuccess("修改成功")
        props.user.phonenumber = form.value.phonenumber
        props.user.email = form.value.email
        if (isStudent.value) {
          props.user.studentNo = form.value.studentNo
          props.user.grade = form.value.grade
          props.user.skillTags = form.value.skillTags
          props.user.deptId = form.value.deptId
          const college = colleges.value.find(item => item.collegeId === form.value.collegeId)
          const major = college?.majors?.find(item => item.deptId === form.value.deptId)
          props.user.dept = {
            deptId: major?.deptId,
            deptName: major?.deptName,
            parentId: college?.collegeId,
            parentName: college?.collegeName
          }
        }
      })
    }
  })
}

function handleCollegeChange() {
  form.value.deptId = null
}

/** 关闭按钮 */
function close() {
  proxy.$tab.closePage()
}

// 回显：用户数据 → form + SkillSelector ID 数组
watch(() => props.user, user => {
  if (user) {
    form.value = { nickName: user.nickName, phonenumber: user.phonenumber, email: user.email, sex: user.sex }
    if (isStudent.value) {
      form.value.studentNo = user.studentNo
      form.value.grade = user.grade
      form.value.skillTags = user.skillTags
      form.value.collegeId = user.dept?.parentId || null
      form.value.deptId = user.deptId || null
    }
    nextTick(() => {
      selectedSkillIds.value = tagsToIds(form.value.skillTags)
    })
  }
}, { immediate: true })

getRegisterDepartments().then(res => {
  colleges.value = Array.isArray(res.data) ? res.data : []
})
</script>
