import auth from '@/plugins/auth'
import router, { constantRoutes, dynamicRoutes } from '@/router'
import { getRouters } from '@/api/menu'
import Layout from '@/layout/index'
import PortalLayout from '@/layout/PortalLayout.vue'
import ParentView from '@/components/ParentView'
import InnerLink from '@/layout/components/InnerLink'
import useUserStore from '@/store/modules/user'

// 匹配views里面所有的.vue文件
const modules = import.meta.glob('./../../views/**/*.vue')

const usePermissionStore = defineStore(
  'permission',
  {
    state: () => ({
      routes: [],
      addRoutes: [],
      defaultRoutes: [],
      topbarRouters: [],
      sidebarRouters: []
    }),
    actions: {
      setRoutes(routes) {
        this.addRoutes = routes
        this.routes = constantRoutes.concat(routes)
      },
      setDefaultRoutes(routes) {
        this.defaultRoutes = constantRoutes.concat(routes)
      },
      setTopbarRoutes(routes) {
        this.topbarRouters = routes
      },
      setSidebarRouters(routes) {
        this.sidebarRouters = routes
      },
      generateRoutes(roles) {
        return new Promise((resolve, reject) => {
          getRouters().then(res => {
            console.log('[generateRoutes] getRouters OK, items:', (res && res.data ? res.data.length : 0))
            const rawData = res && res.data ? res.data : []
            const sdata = JSON.parse(JSON.stringify(rawData))
            const rdata = JSON.parse(JSON.stringify(rawData))
            const defaultData = JSON.parse(JSON.stringify(rawData))

            const userRoles = useUserStore().roles || []
            const isStudent = userRoles.includes('student') || userRoles.includes('ROLE_STUDENT')
            if (isStudent) {
              [sdata, rdata, defaultData].forEach(data => swapLayoutComponent(data))
            }

            console.log('[generateRoutes] filtering sdata...')
            const sidebarRoutes = filterAsyncRouter(sdata)
            console.log('[generateRoutes] filtering rdata...')
            const rewriteRoutes = filterAsyncRouter(rdata, false, true)
            console.log('[generateRoutes] filtering defaultData...')
            const defaultRoutes = filterAsyncRouter(defaultData)
            console.log('[generateRoutes] filterDynamicRoutes...')
            const asyncRoutes = filterDynamicRoutes(dynamicRoutes)
            asyncRoutes.forEach(route => { router.addRoute(route) })
            this.setRoutes(rewriteRoutes)
            this.setSidebarRouters(constantRoutes.concat(sidebarRoutes))
            this.setDefaultRoutes(sidebarRoutes)
            this.setTopbarRoutes(defaultRoutes)
            console.log('[generateRoutes] done, routes:', rewriteRoutes.length)
            resolve(rewriteRoutes)
          }).catch(err => {
            console.error('[generateRoutes] FAILED:', err)
            reject(err)
          })
        })
      }
    }
  })

// 遍历后台传来的路由字符串，转换为组件对象
function filterAsyncRouter(asyncRouterMap, lastRouter = false, type = false) {
  return asyncRouterMap.filter(route => {
    if (type && route.children) {
      route.children = filterChildren(route.children)
    }
    if (route.component) {
      // Layout ParentView 组件特殊处理
      if (route.component === 'Layout') {
        route.component = Layout
      } else if (route.component === 'PortalLayout') {
        route.component = PortalLayout
      } else if (route.component === 'ParentView') {
        route.component = ParentView
      } else if (route.component === 'InnerLink') {
        route.component = InnerLink
      } else {
        route.component = loadView(route.component)
      }
    }
    if (route.children != null && route.children && route.children.length) {
      route.children = filterAsyncRouter(route.children, route, type)
    } else {
      delete route['children']
      delete route['redirect']
    }
    return true
  })
}

function filterChildren(childrenMap, lastRouter = false) {
  var children = []
  childrenMap.forEach(el => {
    el.path = lastRouter ? lastRouter.path + '/' + el.path : el.path
    if (el.children && el.children.length && el.component === 'ParentView') {
      children = children.concat(filterChildren(el.children, el))
    } else {
      children.push(el)
    }
  })
  return children
}

// 动态路由遍历，验证是否具备权限
export function filterDynamicRoutes(routes) {
  const res = []
  routes.forEach(route => {
    if (route.permissions) {
      if (auth.hasPermiOr(route.permissions)) {
        res.push(route)
      }
    } else if (route.roles) {
      if (auth.hasRoleOr(route.roles)) {
        res.push(route)
      }
    }
  })
  return res
}

export const loadView = (view) => {
  let res
  for (const path in modules) {
    const dir = path.split('views/')[1].split('.vue')[0]
    if (dir === view) {
      res = () => modules[path]()
    }
  }
  return res
}

function swapLayoutComponent(routes) {
  if (!Array.isArray(routes)) return
  routes.forEach(route => {
    if (route.component === 'Layout') route.component = 'PortalLayout'
    if (route.children && route.children.length) swapLayoutComponent(route.children)
  })
}

export default usePermissionStore
