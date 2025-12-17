<template>
  <div class="notification-component">
    <span class="notification-label">通知：</span>
    <span class="notification-content">{{ content }}</span>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  content?: string
}>()
</script>

<style scoped lang="scss">
.notification-component {
  display: inline-flex;
  align-items: center;
  padding: 8px 12px;
  margin: 4px 0;
  background: rgba(0, 179, 255, 0.1);
  border-left: 3px solid #00b3ff;
  border-radius: 4px;
  font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
}

.notification-label {
  color: #00b3ff;
  font-weight: 600;
  margin-right: 8px;
  font-size: 13px;
}

.notification-content {
  color: #e1e1e1;
  font-size: 13px;
  line-height: 1.5;
}
</style>
