<template>
  <div class="skill-selector">
    <div class="limit-tip">
      最多选择 5 个核心技能（已选 {{ selectedCount }}/5）
    </div>

    <div class="category-grid">
      <div v-for="(cat, i) in skillCategories" :key="i" class="category-card">
        <div class="card-head">
          <span class="accent-dot" :style="{ background: colors[i] }"></span>
          <span class="card-title">{{ cat.categoryName }}</span>
          <span class="card-badge">{{ selectedInCat(cat) }}</span>
        </div>
        <el-checkbox-group :model-value="safeVal" @update:model-value="onChange" class="tag-group">
          <el-checkbox
            v-for="sk in cat.skills"
            :key="sk.id"
            :label="sk.id"
            :disabled="(selectedCount >= 5) && !safeVal.includes(sk.id)"
            class="tag-item"
          >
            <span class="tag-text">{{ sk.name }}</span>
          </el-checkbox>
        </el-checkbox-group>
      </div>
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

const colors = ['#4f6ef7', '#e6a23c', '#8b5cf6', '#67c23a']

const skillCategories = [
  {
    categoryName: '统筹与表现类',
    skills: [
      { id: 101, name: '路演答辩' }, { id: 102, name: '项目PM' }, { id: 103, name: '市场调研' }
    ]
  },
  {
    categoryName: '商业与文案类',
    skills: [
      { id: 201, name: 'BP撰写' }, { id: 202, name: '财务测算' }, { id: 203, name: '专利/论文撰写' }
    ]
  },
  {
    categoryName: '视觉与设计类',
    skills: [
      { id: 301, name: 'PPT美工' }, { id: 302, name: 'UI/UX设计' }, { id: 303, name: '海报/视频剪辑' }
    ]
  },
  {
    categoryName: '技术与研发类',
    skills: [
      { id: 401, name: '后端架构' }, { id: 402, name: '前端开发' }, { id: 403, name: '算法模型' }, { id: 404, name: '硬件单片机' }
    ]
  }
]

function selectedInCat(cat) {
  const n = cat.skills.filter(sk => safeVal.value.includes(sk.id)).length
  return n ? `${n}/${cat.skills.length}` : ''
}

function onChange(val) {
  const arr = Array.isArray(val) ? val : []
  if (arr.length > 5) return
  emit('update:modelValue', arr)
}
</script>

<style lang="scss" scoped>
.skill-selector { width: 100%; }

.limit-tip {
  padding: 8px 16px;
  margin-bottom: 20px;
  font-size: 13px;
  color: #909399;
  background: #f5f7fa;
  border-radius: 8px;
  text-align: center;
}

.category-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;

  @media (max-width: 640px) {
    grid-template-columns: 1fr;
  }
}

.category-card {
  background: #fff;
  border-radius: 12px;
  padding: 16px 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
  transition: box-shadow 0.2s;
  &:hover { box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); }
}

.card-head {
  display: flex;
  align-items: center;
  margin-bottom: 14px;
}
.accent-dot {
  width: 8px; height: 8px; border-radius: 50%;
  margin-right: 10px; flex-shrink: 0;
}
.card-title {
  font-size: 14px; font-weight: 600; color: #303133; flex: 1;
}
.card-badge {
  font-size: 12px; color: #c0c4cc;
}

.tag-group {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;

  :deep(.tag-item) {
    margin-right: 0;
    height: auto;

    .el-checkbox__input {
      display: none;
    }

    .el-checkbox__label {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 6px 16px;
      border-radius: 20px;
      background: #f5f7fa;
      color: #606266;
      font-size: 13px;
      font-weight: 500;
      line-height: 1.4;
      cursor: pointer;
      user-select: none;
      border: 2px solid transparent;
      transition: all 0.2s ease;

      &:hover {
        background: #ecf5ff;
        color: #4f6ef7;
      }
    }

    &.is-checked .el-checkbox__label {
      background: #ecf5ff;
      color: #4f6ef7;
      border-color: #4f6ef7;
    }

    &.is-disabled .el-checkbox__label {
      cursor: not-allowed;
      opacity: 0.45;
      background: #f5f7fa;
      color: #c0c4cc;
      border-color: transparent;
      &:hover { background: #f5f7fa; color: #c0c4cc; }
    }
  }
}
</style>
