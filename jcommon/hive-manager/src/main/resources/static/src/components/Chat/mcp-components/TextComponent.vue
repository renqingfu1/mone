<template>
  <div class="text-component">
    <div v-if="text" class="text-content">{{ text }}</div>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  text?: string
}>()
</script>

<style scoped lang="scss">
.text-component {
  margin: 8px 0;
  line-height: 1.6;
}

.text-content {
  white-space: pre-wrap;
  word-wrap: break-word;
  color: inherit;
  font-size: inherit;
}
</style>
