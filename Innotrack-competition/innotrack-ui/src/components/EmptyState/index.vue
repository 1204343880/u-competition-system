<template>
  <div class="empty-state">
    <div class="empty-state-illustration">
      <slot name="image">
        <svg-icon :icon-class="icon" :size="size" />
      </slot>
    </div>
    <h4 class="empty-state-title" v-if="title">{{ title }}</h4>
    <p class="empty-state-desc" v-if="description">{{ description }}</p>
    <div class="empty-state-action" v-if="$slots.default">
      <slot />
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: { type: String, default: '' },
  description: { type: String, default: '暂无数据' },
  icon: { type: String, default: 'empty' },
  size: { type: [Number, String], default: 80 }
})
</script>

<style lang="scss" scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48px 24px;
  min-height: 240px;
  text-align: center;
}

.empty-state-illustration {
  margin-bottom: 20px;
  opacity: 0.4;

  :deep(.svg-icon) {
    font-size: 64px;
  }
}

.empty-state-title {
  margin: 0 0 8px;
  font-size: 16px;
  font-weight: 600;
  color: var(--el-text-color-regular, #606266);
}

.empty-state-desc {
  margin: 0 0 20px;
  font-size: 14px;
  color: var(--el-text-color-secondary, #909399);
  max-width: 320px;
  line-height: 1.6;
}

.empty-state-action {
  margin-top: 4px;
}
</style>
