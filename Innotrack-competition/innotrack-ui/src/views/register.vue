<template>
  <div class="auth-page">
    <SchoolLogo :size="56" />
    <el-form ref="registerRef" :model="registerForm" :rules="registerRules" class="register-form">
      <h3 class="title">注册学生账号</h3>
      <p class="subtitle">请填写真实基本信息，注册后将用于参赛与组队</p>

      <div class="form-grid">
        <el-form-item prop="username">
          <el-input v-model="registerForm.username" size="large" autocomplete="username" maxlength="20" placeholder="登录账号">
            <template #prefix><svg-icon icon-class="user" class="input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="nickName">
          <el-input v-model="registerForm.nickName" size="large" maxlength="30" placeholder="真实姓名">
            <template #prefix><svg-icon icon-class="peoples" class="input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="registerForm.password" type="password" show-password size="large" autocomplete="new-password" placeholder="密码">
            <template #prefix><svg-icon icon-class="password" class="input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input v-model="registerForm.confirmPassword" type="password" show-password size="large" autocomplete="new-password" placeholder="确认密码">
            <template #prefix><svg-icon icon-class="password" class="input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="studentNo">
          <el-input v-model="registerForm.studentNo" size="large" maxlength="20" placeholder="学号" />
        </el-form-item>
        <el-form-item prop="grade">
          <el-select v-model="registerForm.grade" size="large" placeholder="选择年级" style="width:100%">
            <el-option v-for="grade in gradeOptions" :key="grade" :label="grade" :value="grade" />
          </el-select>
        </el-form-item>
        <el-form-item prop="collegeId">
          <el-select v-model="registerForm.collegeId" size="large" placeholder="选择学院" style="width:100%" @change="handleCollegeChange">
            <el-option v-for="college in colleges" :key="college.collegeId" :label="college.collegeName" :value="college.collegeId" />
          </el-select>
        </el-form-item>
        <el-form-item prop="deptId">
          <el-select v-model="registerForm.deptId" size="large" placeholder="选择专业" style="width:100%" :disabled="!registerForm.collegeId">
            <el-option v-for="major in availableMajors" :key="major.deptId" :label="major.deptName" :value="major.deptId" />
          </el-select>
        </el-form-item>
        <el-form-item prop="phonenumber">
          <el-input v-model="registerForm.phonenumber" size="large" maxlength="11" placeholder="手机号码" />
        </el-form-item>
        <el-form-item prop="email">
          <el-input v-model="registerForm.email" size="large" maxlength="50" placeholder="邮箱地址" />
        </el-form-item>
        <el-form-item prop="emailCode">
          <div class="sms-row">
            <el-input v-model="registerForm.emailCode" size="large" maxlength="6" placeholder="邮箱验证码" style="flex:1" />
            <el-button
              size="large"
              :disabled="smsCountdown > 0 || smsSending"
              :loading="smsSending"
              class="sms-button"
              @click="handleSendEmailCode"
            >
              {{ smsCountdown > 0 ? smsCountdown + 's后重发' : '获取验证码' }}
            </el-button>
          </div>
        </el-form-item>
        <el-form-item v-if="captchaEnabled" prop="code" class="full-row">
          <div class="captcha-row">
            <el-input v-model="registerForm.code" size="large" autocomplete="off" placeholder="验证码" @keyup.enter="handleRegister">
              <template #prefix><svg-icon icon-class="validCode" class="input-icon" /></template>
            </el-input>
            <img :src="codeUrl" title="点击刷新验证码" class="captcha-image" @click="getCode" />
          </div>
        </el-form-item>
      </div>

      <el-button :loading="loading" :disabled="loading" size="large" type="primary" class="submit-button" @click.prevent="handleRegister">
        {{ loading ? '注册中...' : '注册学生账号' }}
      </el-button>
      <p class="login-tip">已经有账号？<router-link to="/login">返回登录</router-link></p>
    </el-form>
    <div class="auth-footer">{{ footerContent }}</div>
  </div>
</template>

<script setup>
import { ElMessage } from 'element-plus'
import { register, getCodeImg, getRegisterDepartments, sendEmailCode } from '@/api/login'
import SchoolLogo from '@/components/SchoolLogo.vue'
import defaultSettings from '@/settings'

const footerContent = defaultSettings.footerContent
const router = useRouter()
const { proxy } = getCurrentInstance()
const loading = ref(false)
const smsSending = ref(false)
const smsCountdown = ref(0)
let smsTimer = null
const codeUrl = ref('')
const captchaEnabled = ref(true)
const colleges = ref([])
const now = new Date()
const currentYear = now.getFullYear()
const maxGradeYear = now.getMonth() >= 8 ? currentYear : currentYear - 1
const gradeOptions = Array.from({ length: 8 }, (_, index) => `${maxGradeYear - index}级`)
const registerForm = ref({
  username: '', password: '', confirmPassword: '', nickName: '', studentNo: '', grade: '',
  collegeId: null, deptId: null, phonenumber: '', email: '', emailCode: '', code: '', uuid: ''
})

const availableMajors = computed(() => {
  const college = colleges.value.find(item => item.collegeId === registerForm.value.collegeId)
  return college?.majors || []
})

const validateConfirmPassword = (rule, value, callback) => {
  if (value !== registerForm.value.password) callback(new Error('两次输入的密码不一致'))
  else callback()
}

const registerRules = {
  username: [
    { required: true, message: '请输入登录账号', trigger: 'blur' },
    { min: 2, max: 20, message: '账号长度应为2到20个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 5, max: 20, message: '密码长度应为5到20个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请再次输入密码', trigger: 'blur' },
    { validator: validateConfirmPassword, trigger: 'blur' }
  ],
  nickName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
  studentNo: [
    { required: true, message: '请输入学号', trigger: 'blur' },
    { pattern: /^[A-Za-z0-9]{4,20}$/, message: '学号须为4到20位字母或数字', trigger: 'blur' }
  ],
  grade: [{ required: true, message: '请选择年级', trigger: 'change' }],
  collegeId: [{ required: true, message: '请选择学院', trigger: 'change' }],
  deptId: [{ required: true, message: '请选择专业', trigger: 'change' }],
  phonenumber: [
    { required: true, message: '请输入手机号码', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
  ],
  emailCode: [{ required: true, message: '请输入邮箱验证码', trigger: 'blur' }],
  code: [{ required: true, message: '请输入验证码', trigger: 'change' }]
}

function handleCollegeChange() {
  registerForm.value.deptId = null
}

function handleSendEmailCode() {
  const email = registerForm.value.email.trim().toLowerCase()
  if (!email || !/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
    proxy.$refs.registerRef?.validateField('email')
    return
  }
  if (smsSending.value || smsCountdown.value > 0) return
  registerForm.value.email = email
  smsSending.value = true
  sendEmailCode(email).then(() => {
    ElMessage.success('验证码已发送至 ' + email + '，请查收（未配SMTP则看控制台日志）')
    smsCountdown.value = 60
    smsTimer = setInterval(() => {
      smsCountdown.value--
      if (smsCountdown.value <= 0) {
        clearInterval(smsTimer)
        smsTimer = null
      }
    }, 1000)
  }).catch(() => {
    ElMessage.error('验证码发送失败，请稍后重试')
  }).finally(() => {
    smsSending.value = false
  })
}

function handleRegister() {
  if (loading.value) return
  proxy.$refs.registerRef.validate(valid => {
    if (!valid) return
    loading.value = true
    registerForm.value.email = registerForm.value.email.trim().toLowerCase()
    registerForm.value.emailCode = registerForm.value.emailCode.trim()
    registerForm.value.code = registerForm.value.code.trim()
    const { confirmPassword, ...payload } = registerForm.value
    register(payload).then(() => {
      ElMessage.success('学生账号注册成功，请登录')
      router.push({ path: '/login', query: { registered: registerForm.value.username } })
    }).catch((err) => {
      const msg = (err?.message || err || '') + ''
      ElMessage.error(msg && msg !== 'error' ? msg : '注册失败，请检查填写信息后重试')
      const isImageCaptchaError = !msg.includes('邮箱') && (msg.includes('验证码') || msg.includes('captcha') || msg.includes('jcaptcha'))
      if (captchaEnabled.value && isImageCaptchaError) {
        getCode()
      }
    }).finally(() => {
      loading.value = false
    })
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    registerForm.value.code = ''
    registerForm.value.uuid = res.uuid || ''
    codeUrl.value = captchaEnabled.value ? `data:image/gif;base64,${res.img}` : ''
    nextTick(() => proxy.$refs.registerRef?.clearValidate('code'))
  })
}

function loadDepartments() {
  getRegisterDepartments().then(res => {
    colleges.value = Array.isArray(res.data) ? res.data : []
  }).catch(() => {
    ElMessage.error('学院和专业信息加载失败，请确认后端已更新并重启')
  })
}

getCode()
loadDepartments()

onUnmounted(() => {
  if (smsTimer) {
    clearInterval(smsTimer)
    smsTimer = null
  }
})
</script>

<style lang="scss" scoped>
.auth-page { position:relative; display:flex; flex-direction:column; justify-content:center; align-items:center; min-height:100%; padding:30px 20px 66px; overflow-x:hidden; background:radial-gradient(circle at 14% 14%, rgba(26,115,232,.10), transparent 28%),linear-gradient(175deg,#fbfcfe 0%,#f4f6f9 100%); }
.auth-page::after { content:''; position:absolute; right:-150px; bottom:-240px; width:520px; height:520px; border-radius:50%; background:rgba(26,115,232,.045); }
.auth-page > :deep(.school-logo), .auth-page > :first-child { position:relative; z-index:2; }
.register-form { position:relative; z-index:1; width:680px; margin-top:14px; padding:28px 36px 20px; border-radius:18px; background:#fff; box-shadow:0 20px 60px rgba(40,49,62,.10),inset 0 0 0 1px rgba(31,35,41,.035); }
.title { margin:0; text-align:center; color:#26374f; font-size:23px; font-weight:650; letter-spacing:-.025em; }
.subtitle { margin:8px 0 22px; color:#8a8f97; text-align:center; font-size:13px; }
.form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); column-gap:16px; }
.full-row { grid-column:1 / -1; }
.captcha-row { width:100%; display:grid; grid-template-columns:minmax(0,1fr) 120px; gap:10px; }
.sms-row { width:100%; display:flex; gap:10px; }
.sms-button { height:46px; flex-shrink:0; min-width:120px; border-radius:10px; }
.captcha-image { width:120px; height:46px; object-fit:cover; border-radius:10px; cursor:pointer; }
.register-form :deep(.el-input), .register-form :deep(.el-select) { height:46px; }
.register-form :deep(.el-input__wrapper), .register-form :deep(.el-select__wrapper) { min-height:46px; border-radius:11px; box-shadow:inset 0 0 0 1px rgba(31,35,41,.10); }
.register-form :deep(.el-input__wrapper.is-focus), .register-form :deep(.el-select__wrapper.is-focused) { box-shadow:inset 0 0 0 1px #1a73e8,0 0 0 3px rgba(26,115,232,.09); }
.input-icon { width:14px; }
.submit-button { width:100%; height:46px; border:0; border-radius:11px; font-weight:600; box-shadow:0 6px 16px rgba(26,115,232,.16); }
.login-tip { margin:16px 0 0; color:#8a8f97; text-align:center; font-size:13px; }
.login-tip a { color:#1a73e8; text-decoration:none; font-weight:600; }
.auth-footer { position:fixed; z-index:2; bottom:0; width:100%; height:40px; line-height:40px; color:#8a8f97; text-align:center; font-size:12px; letter-spacing:1px; }
@media (max-width:720px) {
  .auth-page { justify-content:flex-start; padding:24px 14px 64px; }
  .register-form { width:100%; max-width:460px; padding:26px 22px 18px; }
  .form-grid { grid-template-columns:1fr; }
  .full-row { grid-column:auto; }
}
</style>
