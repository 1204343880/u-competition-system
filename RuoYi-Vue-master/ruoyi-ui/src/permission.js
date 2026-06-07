import router from './router'
import { ElMessage } from 'element-plus'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isHttp, isPathMatch } from '@/utils/validate'
import { isRelogin } from '@/utils/request'
import useUserStore from '@/store/modules/user'
import useLockStore from '@/store/modules/lock'
import useSettingsStore from '@/store/modules/settings'
import usePermissionStore from '@/store/modules/permission'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/register']

const isWhiteList = (path) => {
  return whiteList.some(pattern => isPathMatch(pattern, path))
}

router.beforeEach(async (to, from) => {
  NProgress.start()
  if (getToken()) {
    to.meta.title && useSettingsStore().setTitle(to.meta.title)
    const isLock = useLockStore().isLock
    if (to.path === '/login') {
      NProgress.done()
      return { path: '/' }
    }
    if (isWhiteList(to.path)) {
      return true
    }
    if (isLock && to.path !== '/lock') {
      NProgress.done()
      return { path: '/lock' }
    }
    if (!isLock && to.path === '/lock') {
      NProgress.done()
      return { path: '/' }
    }
    if (useUserStore().roles.length === 0) {
      isRelogin.show = true
      try {
        // 拉取user_info信息
        await useUserStore().getInfo()
        console.log('[guard] getInfo OK, roles:', useUserStore().roles)
        isRelogin.show = false
        // 根据roles权限生成可访问的路由
        console.log('[guard] calling generateRoutes...')
        const accessRoutes = await usePermissionStore().generateRoutes()
        console.log('[guard] generateRoutes OK, accessRoutes:', accessRoutes.length)
        accessRoutes.forEach(route => {
          if (!isHttp(route.path)) {
            router.addRoute(route)
          }
        })
        console.log('[guard] routes added, checking redirect...')
        const userRoles = useUserStore().roles || []
        const isStudent = userRoles.includes('student') || userRoles.includes('ROLE_STUDENT')
        if (isStudent && (to.path === '/' || to.path === '/index')) {
          const defRoutes = usePermissionStore().defaultRoutes || []
          const firstRoute = defRoutes.find(r => !r.hidden && r.children && r.children.length > 0 && r.path && r.path !== '/')
          if (firstRoute) {
            const firstChild = firstRoute.children[0]
            if (firstChild && firstChild.path) {
              const childPath = firstChild.path.startsWith('/') ? firstChild.path : firstRoute.path + '/' + firstChild.path
              NProgress.done()
              return { path: childPath, replace: true }
            }
          }
        }
        // 重新导航到目标路由，确保动态路由已注册
        console.log('[guard] navigating to:', to.path)
        return { ...to, replace: true }
      } catch (err) {
        console.error('[guard] CATCH ERROR:', err)
        await useUserStore().logOut()
        ElMessage.error(err)
        return { path: '/' }
      }
    }
    return true
  } else {
    // 没有token
    if (isWhiteList(to.path)) {
      // 在免登录白名单，直接进入
      return true
    }
    NProgress.done()
    return `/login?redirect=${to.fullPath}` // 否则全部重定向到登录页
  }
})

router.afterEach(() => {
  NProgress.done()
})
