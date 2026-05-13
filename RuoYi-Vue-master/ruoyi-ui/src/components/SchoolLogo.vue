<template>
  <svg :width="size" :height="size" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M50 5L10 25V45C10 70 30 90 50 95C70 90 90 70 90 45V25L50 5Z" :fill="bgColor" :stroke="strokeColor" stroke-width="4"/>
    <path d="M35 55V45L45 50V40L50 42.5L55 40V50L65 45V55" :stroke="textColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
    <line x1="30" y1="65" x2="70" y2="65" :stroke="textColor" stroke-width="3" stroke-linecap="round"/>
  </svg>
</template>

<script setup>
defineProps({
  size: {
    type: [Number, String],
    default: 40
  },
  bgColor: {
    type: String,
    default: '#004b97'
  },
  strokeColor: {
    type: String,
    default: '#004b97'
  },
  textColor: {
    type: String,
    default: '#ffffff'
  }
})
</script>
