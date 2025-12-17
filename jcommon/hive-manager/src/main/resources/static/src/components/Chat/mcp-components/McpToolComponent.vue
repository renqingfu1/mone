<template>
  <div class="mcp-tool-component">
    <div class="mcp-tool-header">
      <i class="fa-solid fa-robot"></i>
      <span v-if="serverName" class="server-name">{{ serverName }}</span>
      <i v-if="toolName" class="fa-solid fa-wrench"></i>
      <span v-if="toolName" class="tool-name">{{ toolName }}</span>
    </div>
    <div v-if="arguments" class="mcp-tool-content">
      <div class="arguments">
        <pre><code>{{ arguments }}</code></pre>
      </div>
    </div>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  serverName?: string
  toolName?: string
  arguments?: string
}>()
</script>

<style scoped lang="scss">
.mcp-tool-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
  overflow: hidden;
}

.mcp-tool-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;

  i {
    font-size: 16px;
    color: #00b3ff;
    margin-right: 12px;

    &:nth-of-type(2) {
      margin-left: 24px;
      margin-right: 12px;
    }
  }

  .server-name {
    font-weight: 500;
    color: #e1e1e1;

    &::before {
      content: "服务：";
      color: #888;
      font-weight: normal;
      margin-right: 4px;
    }
  }

  .tool-name {
    color: #e1e1e1;

    &::before {
      margin-left: 12px;
      content: "工具：";
      color: #888;
      margin-right: 4px;
    }
  }
}

.mcp-tool-content {
  .arguments {
    margin: 0;
    padding: 15px;

    pre {
      margin: 0;
      white-space: pre-wrap;
      background-color: transparent;

      code {
        font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
        font-size: 0.9em;
        color: #e1e1e1;
        white-space: pre-wrap;
      }
    }
  }
}
</style>
