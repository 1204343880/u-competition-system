import request from '@/utils/request'

// 登录方法
export function login(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid
  }
  return request({
    url: '/login',
    skipAuthExpired: true,
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: data
  })
}

// 注册方法
export function register(data) {
  return request({
    url: '/register',
    skipAuthExpired: true,
    showError: false,
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: data
  })
}

// 获取用户详细信息
export function getInfo(options = {}) {
  return request({
    url: '/getInfo',
    method: 'get',
    skipAuthExpired: options.skipAuthExpired === true
  })
}

// 解锁屏幕
export function unlockScreen(password) {
  return request({
    url: '/unlockscreen',
    method: 'post',
    data: { password }
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    skipAuthExpired: true,
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}

// 获取学生注册可选的学院与专业
export function getRegisterDepartments() {
  return request({
    url: '/register/departments',
    skipAuthExpired: true,
    headers: {
      isToken: false
    },
    method: 'get'
  })
}

// 发送邮箱验证码
export function sendEmailCode(email) {
  return request({
    url: '/register/email/send',
    skipAuthExpired: true,
    headers: {
      isToken: false
    },
    method: 'post',
    data: { email: email }
  })
}
