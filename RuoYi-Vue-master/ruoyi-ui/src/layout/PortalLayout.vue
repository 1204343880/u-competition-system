<template>
  <div class="portal-wrapper">
    <header class="portal-header">
      <div class="portal-header-inner">
        <div class="portal-brand">
          <SchoolLogo :size="30" />
          <span class="portal-title">竞赛信息管理系统</span>
        </div>
        <nav class="portal-nav">
          <router-link to="/index" class="portal-nav-link" :class="{ active: route.path === '/index' }">首页</router-link>
          <template v-for="item in navItems" :key="item.path">
            <el-dropdown v-if="item.children && item.children.length > 0" trigger="hover" :hide-timeout="100" popper-class="portal-dropdown-popper">
              <span class="portal-nav-link" :class="{ active: isActive(item) }">
                {{ item.meta?.title || item.name }}
                <el-icon class="nav-arrow"><ArrowDown /></el-icon>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item v-for="child in visibleChildren(item)" :key="child.path" :class="{ 'is-active': isChildActive(item, child) }" @click="navigateTo(item.path, child.path)">
                    {{ child.meta?.title || child.name }}
                  </el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
            <router-link v-else :to="resolvePath(item)" class="portal-nav-link" :class="{ active: isActive(item) }">
              {{ item.meta?.title || item.name }}
            </router-link>
          </template>
        </nav>
        <div class="right-menu">
          <header-search id="header-search" class="right-menu-item" />
          <screenfull id="screenfull" class="right-menu-item hover-effect" />
          <div class="right-menu-item hover-effect theme-switch-wrapper" @click="toggleTheme($event)">
            <svg-icon v-if="settingsStore.isDark" icon-class="sunny" />
            <svg-icon v-else icon-class="moon" />
          </div>
          <user-notification-bell id="user-notify-bell" class="right-menu-item hover-effect" />
          <el-dropdown @command="handleCommand" class="avatar-container right-menu-item hover-effect" trigger="hover">
            <div class="avatar-wrapper">
              <img :src="userStore.avatar" class="user-avatar" />
              <span class="user-nickname">{{ userStore.nickName }}</span>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <router-link to="/user/profile"><el-dropdown-item>个人中心</el-dropdown-item></router-link>
                <el-dropdown-item divided command="logout"><span>退出登录</span></el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </header>
    <main class="portal-main">
      <div class="portal-stage">
        <router-view v-slot="{ Component, route }">
          <transition name="fade-transform" mode="out-in">
            <keep-alive :include="cachedViews">
              <component :is="Component" :key="route.fullPath" />
            </keep-alive>
          </transition>
        </router-view>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ArrowDown } from '@element-plus/icons-vue'
import { ElMessageBox } from 'element-plus'
import SchoolLogo from '@/components/SchoolLogo.vue'
import Screenfull from '@/components/Screenfull/index.vue'
import HeaderSearch from '@/components/HeaderSearch/index.vue'
import UserNotificationBell from '@/layout/components/UserNotificationBell/index.vue'
import useUserStore from '@/store/modules/user'
import usePermissionStore from '@/store/modules/permission'
import useSettingsStore from '@/store/modules/settings'
import useTagsViewStore from '@/store/modules/tagsView'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()
const permissionStore = usePermissionStore()
const settingsStore = useSettingsStore()
const tagsViewStore = useTagsViewStore()
const cachedViews = computed(() => tagsViewStore.cachedViews)

const navItems = computed(() => (permissionStore.topbarRouters || []).filter(r => !r.hidden && !r.meta?.hidden && r.path && r.path !== '/'))

function visibleChildren(item) { return (item.children || []).filter(c => !c.hidden) }
function resolvePath(item) {
  const children = visibleChildren(item)
  if (children.length) return item.path + '/' + children[0].path
  return item.path || '/'
}
function isActive(item) {
  return route.path === item.path || route.path.startsWith(item.path + '/') ||
    (item.children || []).some(c => route.path.startsWith(item.path + '/' + c.path))
}
function isChildActive(parent, child) { return route.path.startsWith(parent.path + '/' + child.path) }
function navigateTo(parentPath, childPath) { router.push(parentPath + '/' + childPath) }

function handleCommand(cmd) {
  if (cmd === 'logout') {
    ElMessageBox.confirm('确定注销并退出系统吗？', '提示', { confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning' })
      .then(() => userStore.logOut().then(() => { location.href = '/index' })).catch(() => {})
  }
}

/* View Transition API 动画——复刻若依原生切换效果 */
async function toggleTheme(event) {
  const x = event?.clientX || window.innerWidth / 2
  const y = event?.clientY || window.innerHeight / 2
  const wasDark = settingsStore.isDark
  const isSupported = document.startViewTransition && !window.matchMedia('(prefers-reduced-motion: reduce)').matches

  if (!isSupported) {
    settingsStore.toggleTheme()
    return
  }
  try {
    const transition = document.startViewTransition(async () => {
      await new Promise(resolve => setTimeout(resolve, 10))
      settingsStore.toggleTheme()
      await nextTick()
    })
    await transition.ready
    const endRadius = Math.hypot(Math.max(x, window.innerWidth - x), Math.max(y, window.innerHeight - y))
    const clipPath = [`circle(0px at ${x}px ${y}px)`, `circle(${endRadius}px at ${x}px ${y}px)`]
    document.documentElement.animate(
      { clipPath: !wasDark ? [...clipPath].reverse() : clipPath },
      { duration: 650, easing: 'cubic-bezier(0.4, 0, 0.2, 1)', fill: 'forwards', pseudoElement: !wasDark ? '::view-transition-old(root)' : '::view-transition-new(root)' }
    )
    await transition.finished
  } catch {
    settingsStore.toggleTheme()
  }
}
</script>

<style scoped>
.portal-wrapper { --portal-primary:#1a73e8; --portal-header-height:64px; display:flex; flex-direction:column; min-height:100vh; background:var(--el-bg-color-page, #f5f7fa); }
.portal-header { position:sticky; top:0; z-index:100; height:var(--portal-header-height); background:var(--el-bg-color-overlay,#fff); box-shadow:0 1px 2px rgba(60,64,67,.15),0 1px 3px 1px rgba(60,64,67,.10); flex-shrink:0; }
.portal-header-inner { display:flex; align-items:center; height:100%; padding:0 28px; max-width:1440px; margin:0 auto; }
.portal-brand { display:flex; align-items:center; gap:10px; flex-shrink:0; }
.portal-title { font-size:17px; font-weight:600; color:var(--el-text-color-primary,#202124); white-space:nowrap; }
.portal-nav { flex:1; display:flex; align-items:center; justify-content:center; gap:32px; height:100%; }
.portal-nav-link { display:inline-flex; align-items:center; gap:4px; height:40px; padding:0 32px; border-radius:8px; font-size:16px; font-weight:500; color:var(--el-text-color-regular,#5f6368); text-decoration:none; transition:background .2s,color .2s; white-space:nowrap; cursor:pointer; user-select:none; }
.portal-nav-link:hover { background:var(--el-fill-color-light,#f1f3f4); color:var(--el-text-color-primary,#202124); }
.portal-nav-link.active { background:rgba(26,115,232,.1); color:var(--portal-primary); }
.nav-arrow { font-size:12px; }
.right-menu { height:100%; display:flex; align-items:center; margin-left:auto; flex-shrink:0; }
.right-menu :deep(.right-menu-item) { display:inline-flex; align-items:center; justify-content:center; padding:0 8px; height:100%; font-size:18px; color:var(--el-text-color-regular,#5a5e66); }
.right-menu :deep(.hover-effect) { cursor:pointer; transition:background .3s; }
.right-menu :deep(.hover-effect:hover) { background:rgba(128,128,128,.08); }
.right-menu :deep(.theme-switch-wrapper svg) { transition:transform .3s; }
.right-menu :deep(.theme-switch-wrapper:hover svg) { transform:scale(1.15); }
.right-menu :deep(.avatar-container) { margin-right:0; padding-right:0; }
.right-menu :deep(.avatar-wrapper) { display:flex; align-items:center; }
.right-menu :deep(.user-avatar) { width:30px; height:30px; margin-right:8px; border-radius:50%; }
.right-menu :deep(.user-nickname) { font-size:14px; font-weight:700; color:var(--el-text-color-regular,#5a5e66); }
.right-menu :deep(.notice-trigger) { display:inline-flex; align-items:center; position:relative; }
.right-menu :deep(.notice-badge) { position:absolute; top:6px; right:-5px; background:#f56c6c; color:#fff; border-radius:10px; font-size:10px; height:16px; line-height:16px; padding:0 5px; min-width:16px; text-align:center; white-space:nowrap; pointer-events:none; }
.portal-main { flex:1; min-height:0; background:var(--el-bg-color-page,#f5f7fa); }
.portal-stage { padding:24px; min-height:calc(100vh - var(--portal-header-height)); }
a { text-decoration:none; }
@media (max-width:768px) { .portal-nav-link { padding:0 12px; font-size:14px; } .user-nickname { display:none; } }
@media (max-width:640px) { .portal-title { display:none; } }
</style>

<style lang="scss">
.portal-dropdown-popper { border-radius:12px!important; border:none!important; box-shadow:0 1px 3px 0 rgba(60,64,67,.3),0 4px 8px 3px rgba(60,64,67,.15)!important; padding:8px 0!important;
  .el-dropdown-menu__item { padding:8px 20px; font-size:14px; color:var(--el-text-color-primary); font-weight:500;
    &:hover { background:var(--el-fill-color-light); }
    &.is-active { background:rgba(26,115,232,.1); color:#1a73e8; }
  }
}
.portal-main {
  .el-table { border:none!important; &::before{display:none;}
    th.el-table__cell { background:var(--el-fill-color-light)!important; border-right:none!important; border-bottom:2px solid var(--el-border-color-lighter)!important; color:var(--el-text-color-regular); font-weight:600; font-size:13px; }
    td.el-table__cell { border-right:none!important; border-bottom:1px solid var(--el-border-color-extra-light)!important; color:var(--el-text-color-primary); }
    tr:last-child td.el-table__cell { border-bottom:none!important; }
  }
  .el-card { border:none!important; border-radius:12px!important; box-shadow:0 4px 16px 0 rgba(0,0,0,.04)!important; background:var(--el-bg-color-overlay)!important; }
  .el-pagination { margin-top:24px; justify-content:center; }
  .el-dialog { border-radius:12px; }
  .el-dialog__header { padding:24px 28px 0; }
  .el-dialog__title { font-size:18px; font-weight:600; color:var(--el-text-color-primary); }
  .el-dialog__body { padding:20px 28px; }
  .el-dialog__footer { padding:0 28px 24px; }
  .el-form-item__label { color:var(--el-text-color-regular); font-weight:500; }
  .el-input__wrapper { border-radius:8px; }
  .el-tag { border:none!important; border-radius:14px!important; }
}
</style>
