<template>
  <div class="skeleton" :class="`skeleton--${type}`">
    <!-- 表格骨架 -->
    <template v-if="type === 'table'">
      <div class="skeleton-table">
        <div class="skeleton-table-header">
          <div class="skeleton-cell" v-for="i in cols" :key="'h' + i" :style="{ width: headerWidths[i - 1] || '100px' }" />
        </div>
        <div class="skeleton-table-row" v-for="r in rows" :key="r">
          <div class="skeleton-cell" v-for="c in cols" :key="c" :style="{ width: cellWidths[c - 1] || 'auto' }" />
        </div>
      </div>
    </template>

    <!-- 卡片骨架 -->
    <template v-if="type === 'card'">
      <div class="skeleton-card" v-for="i in count" :key="i">
        <div class="skeleton-card-image" />
        <div class="skeleton-card-body">
          <div class="skeleton-line skeleton-line--title" />
          <div class="skeleton-line skeleton-line--text" />
          <div class="skeleton-line skeleton-line--text short" />
        </div>
      </div>
    </template>

    <!-- 表单骨架 -->
    <template v-if="type === 'form'">
      <div class="skeleton-form">
        <div class="skeleton-form-item" v-for="i in count" :key="i">
          <div class="skeleton-line skeleton-line--label" />
          <div class="skeleton-line skeleton-line--input" />
        </div>
        <div class="skeleton-form-footer">
          <div class="skeleton-line skeleton-line--button" />
          <div class="skeleton-line skeleton-line--button" />
        </div>
      </div>
    </template>

    <!-- 详情骨架 -->
    <template v-if="type === 'detail'">
      <div class="skeleton-detail">
        <div class="skeleton-line skeleton-line--title" />
        <div class="skeleton-detail-grid">
          <div class="skeleton-detail-item" v-for="i in count" :key="i">
            <div class="skeleton-line skeleton-line--label" />
            <div class="skeleton-line skeleton-line--value" />
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
defineProps({
  type: { type: String, default: 'table', validator: v => ['table', 'card', 'form', 'detail'].includes(v) },
  rows: { type: Number, default: 5 },
  cols: { type: Number, default: 4 },
  count: { type: Number, default: 3 },
  headerWidths: { type: Array, default: () => [] },
  cellWidths: { type: Array, default: () => [] }
})
</script>

<style lang="scss" scoped>
@keyframes skeleton-shimmer {
  0% { background-position: -200px 0; }
  100% { background-position: calc(200px + 100%) 0; }
}

.skeleton {
  padding: 20px;
}

.skeleton-line,
.skeleton-cell {
  background: linear-gradient(90deg,
    var(--el-fill-color-light, #f0f0f0) 25%,
    var(--el-fill-color-lighter, #f8f8f8) 37%,
    var(--el-fill-color-light, #f0f0f0) 63%
  );
  background-size: 200px 100%;
  animation: skeleton-shimmer 1.4s ease infinite;
  border-radius: 4px;
}

/* === Table Skeleton === */
.skeleton-table-header {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
  .skeleton-cell { height: 20px; }
}

.skeleton-table-row {
  display: flex;
  gap: 12px;
  margin-bottom: 12px;
  .skeleton-cell {
    height: 14px;
    flex: 1;
    min-width: 48px;
  }
}

/* === Card Skeleton === */
.skeleton-card {
  display: flex;
  gap: 16px;
  padding: 16px;
  margin-bottom: 12px;
  background: var(--el-bg-color, #fff);
  border-radius: 12px;
  border: 1px solid var(--el-border-color-lighter, #ebeef5);
}

.skeleton-card-image {
  width: 80px;
  height: 80px;
  flex-shrink: 0;
  border-radius: 8px;
  background: linear-gradient(90deg,
    var(--el-fill-color-light, #f0f0f0) 25%,
    var(--el-fill-color-lighter, #f8f8f8) 37%,
    var(--el-fill-color-light, #f0f0f0) 63%
  );
  background-size: 200px 100%;
  animation: skeleton-shimmer 1.4s ease infinite;
}

.skeleton-card-body {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 10px;
  justify-content: center;
}

.skeleton-line--title {
  width: 60%;
  height: 18px;
}

.skeleton-line--text {
  width: 100%;
  height: 14px;
  &.short { width: 40%; }
}

/* === Form Skeleton === */
.skeleton-form-item {
  margin-bottom: 24px;
}

.skeleton-line--label {
  width: 80px;
  height: 16px;
  margin-bottom: 8px;
}

.skeleton-line--input {
  width: 100%;
  max-width: 480px;
  height: 36px;
  border-radius: 6px;
}

.skeleton-form-footer {
  display: flex;
  gap: 12px;
  margin-top: 32px;
}

.skeleton-line--button {
  width: 80px;
  height: 36px;
  border-radius: 6px;
}

/* === Detail Skeleton === */
.skeleton-detail {
  padding: 4px 0;
}

.skeleton-detail-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
  margin-top: 20px;
}

.skeleton-detail-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.skeleton-line--value {
  width: 70%;
  height: 14px;
}

.skeleton-line--title {
  width: 40%;
  height: 24px;
}
</style>
