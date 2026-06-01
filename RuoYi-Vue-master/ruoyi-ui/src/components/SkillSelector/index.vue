<template>
  <div class="skill-selector">
    <div class="limit-tip">
      最多选择 5 个核心技能（已选 {{ selectedCount }}/5）
    </div>
    <div v-for="(cat, i) in skillCategories" :key="i" class="skill-category">
      <div class="category-title">
        <span class="accent-bar" :style="{ background: colors[i] }"></span>
        <span>{{ cat.categoryName }}</span>
      </div>
      <el-checkbox-group :model-value="safeVal" @update:model-value="onChange" class="skill-group">
        <el-checkbox-button
          v-for="sk in cat.skills"
          :key="sk.id"
          :value="sk.id"
          :disabled="(selectedCount >= 5) && !safeVal.includes(sk.id)"
        >{{ sk.name }}</el-checkbox-button>
      </el-checkbox-group>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  modelValue: { type: Array, default: () => [] }
})
const emit = defineEmits(['update:modelValue'])

const safeVal = computed(() => Array.isArray(props.modelValue) ? props.modelValue : [])
const selectedCount = computed(() => safeVal.value.length)

const colors = ['#409EFF', '#E6A23C', '#8B5CF6', '#67C23A']

const skillCategories = [
  {
    categoryName: '统筹与表现类',
    skills: [
      { id: 101, name: '路演答辩' },
      { id: 102, name: '项目PM' },
      { id: 103, name: '市场调研' }
    ]
  },
  {
    categoryName: '商业与文案类',
    skills: [
      { id: 201, name: 'BP撰写' },
      { id: 202, name: '财务测算' },
      { id: 203, name: '专利/论文撰写' }
    ]
  },
  {
    categoryName: '视觉与设计类',
    skills: [
      { id: 301, name: 'PPT美工' },
      { id: 302, name: 'UI/UX设计' },
      { id: 303, name: '海报/视频剪辑' }
    ]
  },
  {
    categoryName: '技术与研发类',
    skills: [
      { id: 401, name: '后端架构' },
      { id: 402, name: '前端开发' },
      { id: 403, name: '算法模型' },
      { id: 404, name: '硬件单片机' }
    ]
  }
]

function onChange(val) {
  const arr = Array.isArray(val) ? val : []
  if (arr.length > 5) return
  emit('update:modelValue', arr)
}
</script>

<style lang="scss" scoped>
.skill-selector { width: 100%; }

.limit-tip {
  padding: 9px 14px; margin-bottom: 20px; font-size: 13px;
  color: #909399; background: #f5f7fa; border-radius: 6px; text-align: center;
}

.skill-category { margin-bottom: 22px; &:last-child { margin-bottom: 0; } }

.category-title {
  display: flex; align-items: center; margin-bottom: 14px;
  font-size: 15px; font-weight: 600; color: #303133;
  .accent-bar { display: inline-block; width: 4px; height: 18px; border-radius: 2px; margin-right: 10px; flex-shrink: 0; }
}

.skill-group {
  display: flex; flex-wrap: wrap; gap: 10px;
  :deep(.el-checkbox-button) {
    margin: 0;
    .el-checkbox-button__inner {
      border-radius: 8px !important; padding: 8px 16px; min-width: 80px;
      border: 1px solid #dcdfe6; background: #fff; box-shadow: none !important; transition: all .2s;
      &:hover { border-color: var(--el-color-primary); color: var(--el-color-primary); }
    }
    &.is-checked .el-checkbox-button__inner { background: var(--el-color-primary); border-color: var(--el-color-primary); color: #fff; }
    &.is-disabled .el-checkbox-button__inner { cursor: not-allowed; opacity: .5; background: #f5f7fa; border-color: #e4e7ed; color: #c0c4cc; }
  }
  :deep(.el-checkbox-button:first-child .el-checkbox-button__inner) { border-left: 1px solid #dcdfe6; }
}
</style>
