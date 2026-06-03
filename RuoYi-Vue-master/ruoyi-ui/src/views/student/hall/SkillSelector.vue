<template>
  <el-dialog title="选择所需技能" v-model="visible" width="400px" append-to-body>
    <el-checkbox-group v-model="selectedSkills">
      <el-checkbox v-for="s in skillOptions" :key="s" :value="s" :label="s" style="margin-right: 12px; margin-bottom: 8px" />
    </el-checkbox-group>
    <div v-if="!skillOptions.length" style="color: #909399; text-align: center; padding: 20px">
      请先在个人中心填写自己的技能标签
    </div>
    <template #footer>
      <el-button type="primary" @click="handleConfirm">确认</el-button>
      <el-button @click="visible = false">取消</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import useUserStore from '@/store/modules/user'

const props = defineProps({
  modelValue: { type: Boolean, default: false },
  currentSkills: { type: String, default: '' }
})
const emit = defineEmits(['update:modelValue', 'save'])

const userStore = useUserStore()
const visible = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v)
})
const skillOptions = computed(() => {
  const tags = userStore.skillTags || ''
  return tags.split(',').map(s => s.trim()).filter(Boolean)
})
const selectedSkills = ref([])

watch(() => props.currentSkills, (val) => {
  selectedSkills.value = (val || '').split(',').map(s => s.trim()).filter(Boolean)
}, { immediate: true })

function handleConfirm() {
  emit('save', selectedSkills.value.join(','))
  visible.value = false
}
</script>
