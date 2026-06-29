<template>
  <div class="auth-page">
    <SchoolLogo :size="56" />
    <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="auth-form">
      <h3 class="title">竞赛信息管理系统</h3>
      <p class="subtitle">欢迎回来，请登录你的账号</p>

      <el-form-item prop="username">
        <el-input v-model="loginForm.username" size="large" autocomplete="username" placeholder="登录账号">
          <template #prefix><svg-icon icon-class="user" class="input-icon" /></template>
        </el-input>
      </el-form-item>

      <el-form-item prop="password">
        <el-input v-model="loginForm.password" type="password" show-password size="large" autocomplete="current-password" placeholder="密码" @keyup.enter="handleLogin">
          <template #prefix><svg-icon icon-class="password" class="input-icon" /></template>
        </el-input>
      </el-form-item>

      <el-form-item v-if="captchaEnabled" prop="code">
        <div class="captcha-row">
          <el-input v-model="loginForm.code" size="large" autocomplete="off" placeholder="验证码" @keyup.enter="handleLogin">
            <template #prefix><svg-icon icon-class="validCode" class="input-icon" /></template>
          </el-input>
          <img :src="codeUrl" title="点击刷新验证码" class="captcha-image" @click="getCode" />
        </div>
      </el-form-item>

      <el-checkbox v-model="loginForm.rememberMe" class="remember-me">记住密码</el-checkbox>

      <el-button :loading="loading" size="large" type="primary" class="submit-button" @click.prevent="handleLogin">
        {{ loading ? '登录中...' : '登录' }}
      </el-button>

      <p class="register-tip">
        还没有学生账号？
        <router-link to="/register">立即注册</router-link>
      </p>
    </el-form>
    <div class="auth-footer">{{ footerContent }}</div>
  </div>
</template>

<script setup>
import Cookies from 'js-cookie'
import { getCodeImg } from '@/api/login'
import { encrypt, decrypt } from '@/utils/jsencrypt'
import useUserStore from '@/store/modules/user'
import SchoolLogo from '@/components/SchoolLogo.vue'
import defaultSettings from '@/settings'

const footerContent = defaultSettings.footerContent
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loading = ref(false)
const codeUrl = ref('')
const captchaEnabled = ref(true)
const redirect = ref(undefined)
const loginForm = ref({ username: '', password: '', rememberMe: false, code: '', uuid: '' })
const loginRules = {
  username: [
    { required: true, message: '请输入登录账号', trigger: 'blur' },
    { min: 2, max: 20, message: '账号长度应为2到20个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 5, max: 20, message: '密码长度应为5到20个字符', trigger: 'blur' }
  ],
  code: [{ required: true, message: '请输入验证码', trigger: 'change' }]
}

watch(route, newRoute => {
  redirect.value = newRoute.query?.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (!valid) return
    loading.value = true
    if (loginForm.value.rememberMe) {
      Cookies.set('username', loginForm.value.username, { expires: 30 })
      Cookies.set('password', encrypt(loginForm.value.password), { expires: 30 })
      Cookies.set('rememberMe', 'true', { expires: 30 })
    } else {
      Cookies.remove('username')
      Cookies.remove('password')
      Cookies.remove('rememberMe')
    }
    userStore.login(loginForm.value).then(() => {
      router.push(redirect.value || '/')
    }).catch(() => {
      loading.value = false
      if (captchaEnabled.value) getCode()
    })
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    loginForm.value.code = ''
    loginForm.value.uuid = res.uuid || ''
    codeUrl.value = captchaEnabled.value ? `data:image/gif;base64,${res.img}` : ''
  })
}

function getCookie() {
  const registeredUsername = String(route.query?.registered || '')
  const username = registeredUsername || Cookies.get('username')
  const password = registeredUsername ? '' : Cookies.get('password')
  loginForm.value.username = username || ''
  loginForm.value.password = password ? decrypt(password) : ''
  loginForm.value.rememberMe = !registeredUsername && Cookies.get('rememberMe') === 'true'
}

getCookie()
getCode()
</script>

<style lang="scss" scoped>
.auth-page {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100%;
  padding: 34px 20px 72px;
  overflow-x: hidden;
  background: radial-gradient(circle at 14% 14%, rgba(26,115,232,.10), transparent 28%), linear-gradient(175deg,#fbfcfe 0%,#f4f6f9 100%);
}
.auth-page::after { content:''; position:absolute; right:-150px; bottom:-240px; width:520px; height:520px; border-radius:50%; background:rgba(26,115,232,.045); }
.auth-page > :deep(.school-logo), .auth-page > :first-child { position:relative; z-index:2; }
.auth-form { position:relative; z-index:1; width:400px; margin-top:16px; padding:30px 36px 24px; border-radius:18px; background:#fff; box-shadow:0 20px 60px rgba(40,49,62,.10), inset 0 0 0 1px rgba(31,35,41,.035); }
.title { margin:0; text-align:center; color:#26374f; font-size:23px; font-weight:650; letter-spacing:-.025em; }
.subtitle { margin:8px 0 24px; color:#8a8f97; text-align:center; font-size:13px; }
.captcha-row { width:100%; display:grid; grid-template-columns:minmax(0,1fr) 120px; gap:10px; }
.captcha-image { width:120px; height:46px; object-fit:cover; border-radius:10px; cursor:pointer; }
.auth-form :deep(.el-input) { height:46px; }
.auth-form :deep(.el-input__wrapper) { min-height:46px; border-radius:11px; box-shadow:inset 0 0 0 1px rgba(31,35,41,.10); }
.auth-form :deep(.el-input__wrapper.is-focus) { box-shadow:inset 0 0 0 1px #1a73e8,0 0 0 3px rgba(26,115,232,.09); }
.input-icon { width:14px; }
.remember-me { margin:0 0 18px; }
.submit-button { width:100%; height:46px; border:0; border-radius:11px; font-weight:600; box-shadow:0 6px 16px rgba(26,115,232,.16); }
.register-tip { margin:18px 0 0; color:#8a8f97; text-align:center; font-size:13px; }
.register-tip a { color:#1a73e8; text-decoration:none; font-weight:600; }
.auth-footer { position:fixed; z-index:2; bottom:0; width:100%; height:40px; line-height:40px; color:#8a8f97; text-align:center; font-size:12px; letter-spacing:1px; }
@media (max-width: 520px) {
  .auth-page { justify-content:flex-start; padding:24px 14px 64px; }
  .auth-form { width:100%; max-width:420px; padding:26px 22px 22px; }
}
</style>
