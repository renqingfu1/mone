<template>
  <div class="memory-component">
    <div class="memory-header">
      <i class="fa-solid fa-lightbulb"></i>
      <span>记忆过程</span>
    </div>
    <div class="memory-content">
      <slot>
        <div v-if="text" class="memory-text">{{ text }}</div>
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  text?: string
}>()
</script>

<style scoped lang="scss">
.memory-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  line-height: 0;
  overflow: hidden;
}

.memory-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: rgba(0, 0, 0, 0.5);
  border-bottom: 1px solid #3d3d3d;
  cursor: pointer;
  user-select: none;

  i {
    font-size: 16px;
    color: #00b3ff;
    margin-right: 12px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
  }
}

.memory-content {
  padding: 16px 24px;
  color: #e1e1e1;
  line-height: 1.6;
  background: #1e1e1e;
  display: block;
}

.memory-text {
  white-space: pre-wrap;
  word-wrap: break-word;
}
</style>
