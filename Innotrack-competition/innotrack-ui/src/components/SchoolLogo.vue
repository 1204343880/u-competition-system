<template>
  <img :src="logoSrc" :style="{ width: size + 'px', height: size + 'px', objectFit: 'contain', verticalAlign: 'middle' }" alt="Logo" />
</template>

<script setup>
import logoImg from '@/assets/logo/templogo.png'

defineProps({
  size: { type: [Number, String], default: 40 }
})

const logoSrc = logoImg
</script>
