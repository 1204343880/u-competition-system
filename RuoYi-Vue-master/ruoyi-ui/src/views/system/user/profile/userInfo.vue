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
         <el-form-item label="技能标签" prop="skillTags">
            <el-input v-model="form.skillTags" maxlength="100" placeholder="多个标签用逗号分隔，如：编程,路演,PPT" />
         </el-form-item>
      </template>
      <el-form-item>
      <el-button type="primary" @click="submit">保存</el-button>
      <el-button type="danger" @click="close">关闭</el-button>
      </el-form-item>
   </el-form>
</template>

<script setup>
import { updateUserProfile } from "@/api/system/user"

const props = defineProps({
  user: {
    type: Object
  }
})

const { proxy } = getCurrentInstance()

const form = ref({})
const rules = ref({
  nickName: [{ required: true, message: "用户昵称不能为空", trigger: "blur" }],
  email: [{ required: true, message: "邮箱地址不能为空", trigger: "blur" }, { type: "email", message: "请输入正确的邮箱地址", trigger: ["blur", "change"] }],
  phonenumber: [{ required: true, message: "手机号码不能为空", trigger: "blur" }, { pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/, message: "请输入正确的手机号码", trigger: "blur" }],
})

// 竞赛系统扩展：判断当前用户是否为参赛学生角色
const isStudent = computed(() => {
  return props.user?.roles?.some(role => role.roleKey === 'student')
})

/** 提交按钮 */
function submit() {
  proxy.$refs.userRef.validate(valid => {
    if (valid) {
      updateUserProfile(form.value).then(() => {
        proxy.$modal.msgSuccess("修改成功")
        props.user.phonenumber = form.value.phonenumber
        props.user.email = form.value.email
        // 竞赛系统扩展：回写学生专属字段
        if (isStudent.value) {
          props.user.studentNo = form.value.studentNo
          props.user.grade = form.value.grade
          props.user.skillTags = form.value.skillTags
        }
      })
    }
  })
}

/** 关闭按钮 */
function close() {
  proxy.$tab.closePage()
}

// 回显当前登录用户信息
// 竞赛系统扩展：学生角色额外回显 studentNo、grade、skillTags
watch(() => props.user, user => {
  if (user) {
    form.value = { nickName: user.nickName, phonenumber: user.phonenumber, email: user.email, sex: user.sex }
    if (isStudent.value) {
      form.value.studentNo = user.studentNo
      form.value.grade = user.grade
      form.value.skillTags = user.skillTags
    }
  }
},{ immediate: true })
</script>
