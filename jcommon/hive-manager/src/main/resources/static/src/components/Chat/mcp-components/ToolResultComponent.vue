<template>
  <div class="tool-result-component">
    <div class="tool-result-header">
      <i class="fa-solid fa-code"></i>
      <span>工具结果</span>
    </div>
    <div class="tool-result-content">
      <slot>
        <div v-if="text" class="tool-result-text">{{ text }}</div>
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
.tool-result-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.tool-result-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;

  i {
    font-size: 16px;
    color: #3498db;
    margin-right: 12px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
  }
}

.tool-result-content {
  padding: 16px 24px;
  color: #e1e1e1;
  line-height: 1.6;
  background: #1e1e1e;
  max-height: 400px;
  overflow-y: auto;

  &::-webkit-scrollbar {
    width: 8px;
  }

  &::-webkit-scrollbar-track {
    background: rgba(136, 136, 136, 0.1);
    border-radius: 4px;
  }

  &::-webkit-scrollbar-thumb {
    background: rgba(52, 152, 219, 0.6);
    border-radius: 4px;

    &:hover {
      background: rgba(52, 152, 219, 0.8);
    }
  }
}

.tool-result-text {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
  font-size: 0.9em;
}
</style>
