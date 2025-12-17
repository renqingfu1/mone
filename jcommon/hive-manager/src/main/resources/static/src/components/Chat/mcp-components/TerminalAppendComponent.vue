<template>
  <div class="terminal-append-component">
    <div class="terminal-process-header">
      <i class="fa-solid fa-terminal"></i>
      <span>进程 {{ pid }}</span>
    </div>
    <div :id="`process-${pid}`" class="terminal-process-content">
      <slot>
        <div v-if="content" class="process-text">{{ content }}</div>
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  pid?: string
  content?: string
}>()
</script>

<style scoped lang="scss">
.terminal-append-component {
  margin: 15px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  border-left: 4px solid #67c23a;
  overflow: hidden;
}

.terminal-process-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: linear-gradient(135deg, rgba(103, 194, 58, 0.1), rgba(46, 204, 113, 0.1));
  color: #67c23a;
  font-weight: 600;

  i {
    margin-right: 10px;
    color: #67c23a;
    font-size: 1.1em;
  }

  span {
    font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
    letter-spacing: 0.5px;
    flex: 1;
  }
}

.terminal-process-content {
  padding: 16px 24px;
  background: #1e1e1e;
  line-height: 1.4;
  max-height: 300px;
  overflow-y: auto;

  &::-webkit-scrollbar {
    width: 8px;
  }

  &::-webkit-scrollbar-track {
    background: rgba(136, 136, 136, 0.1);
    border-radius: 4px;
  }

  &::-webkit-scrollbar-thumb {
    background: rgba(103, 194, 58, 0.6);
    border-radius: 4px;

    &:hover {
      background: rgba(103, 194, 58, 0.8);
    }
  }
}

.process-text {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
  font-size: 0.95em;
  color: #e1e1e1;
}
</style>
