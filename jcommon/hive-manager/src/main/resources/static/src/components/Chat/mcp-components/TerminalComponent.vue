<template>
  <div class="terminal-component">
    <slot>
      <div v-if="text" class="terminal-text">{{ text }}</div>
    </slot>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  text?: string
}>()
</script>

<style scoped lang="scss">
.terminal-component {
  background: #1e1e1e;
  padding: 12px;
  margin: 10px 0;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  position: relative;
  color: #fff !important;

  &::before {
    content: '';
    position: absolute;
    left: 13px;
    top: 13px;
    width: 12px;
    height: 12px;
    background: #ff5f56;
    border-radius: 50%;
    box-shadow: 
      22px 0 0 #ffbd2e,
      44px 0 0 #27c93f;
  }
}

.terminal-text {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
  font-size: 0.9em;
  line-height: 1.4;
  padding-left: 70px;
}
</style>
