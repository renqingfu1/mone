<template>
  <div class="attempt-completion-component">
    <div class="completion-result">
      <div class="result-header">
        <i class="fa-solid fa-circle-check"></i>
        <span>执行完成</span>
      </div>
      <div v-if="result" class="result-content">{{ result }}</div>
    </div>
    <div v-if="command" class="completion-command">
      <div class="command-header">
        <i class="fa-solid fa-terminal"></i>
        <span>命令</span>
      </div>
      <div class="command-content">
        <pre><code>{{ command }}</code></pre>
      </div>
    </div>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  result?: string
  command?: string
}>()
</script>

<style scoped lang="scss">
.attempt-completion-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.result-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #67c23a;
  border-bottom: 1px solid #3d3d3d;

  i {
    font-size: 16px;
    color: #00d9b2;
    margin-right: 12px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
  }
}

.result-content {
  color: #67c23a;
  line-height: 1.6;
  padding: 15px;
  background: #1e1e1e;
}

.completion-command {
  border-top: 1px solid #3d3d3d;
  margin-top: 8px;
}

.command-header {
  display: flex;
  align-items: center;
  padding: 12px 15px;
  background: #909399;
  border-radius: 6px 6px 0 0;

  i {
    color: #00b3ff;
    font-size: 14px;
    margin-right: 8px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
    font-size: 0.9em;
  }
}

.command-content {
  background: #2d2d2d;
  padding: 12px 15px;
  border-radius: 0 0 6px 6px;
  margin: 0;

  pre {
    margin: 0;
    padding: 8px;
    background: #1e1e1e;
    border-radius: 4px;
    overflow-x: auto;

    code {
      font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
      font-size: 0.9em;
      color: #00b3ff;
      padding: 0;
      background: transparent;
    }
  }
}
</style>
