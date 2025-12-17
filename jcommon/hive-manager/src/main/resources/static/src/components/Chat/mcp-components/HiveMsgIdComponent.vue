<template>
  <div class="hive-checkpoint-container">
    <button 
      class="hive-checkpoint-btn" 
      :data-msg-id="msgId" 
      :title="`消息检查点: ${msgId}`"
      @click="handleClick"
    >
      <i class="fa-solid fa-bookmark"></i>
      <span class="checkpoint-text">Checkpoint</span>
      <code class="checkpoint-id">{{ msgId }}</code>
    </button>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  msgId?: string
}>()

const emit = defineEmits<{
  click: [msgId: string]
}>()

const handleClick = () => {
  if (props.msgId) {
    emit('click', props.msgId)
  }
}
</script>

<style scoped lang="scss">
.hive-checkpoint-container {
  margin: 16px 0;
  display: flex;
  justify-content: center;
}

.hive-checkpoint-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background: linear-gradient(135deg, #9c27b0 0%, #8e44ad 100%);
  color: white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 13px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(156, 39, 176, 0.3);
  position: relative;
  overflow: hidden;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(156, 39, 176, 0.4);
  }

  &:active {
    transform: translateY(-1px);
  }

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.6s ease;
  }

  &:hover::before {
    left: 100%;
  }

  .fa-bookmark {
    font-size: 14px;
    color: #ff9500;
  }

  .checkpoint-text {
    font-weight: 600;
    letter-spacing: 0.3px;
  }

  .checkpoint-id {
    background: rgba(255, 255, 255, 0.2);
    padding: 2px 8px;
    border-radius: 10px;
    font-family: 'JetBrains Mono', Consolas, Monaco, monospace;
    font-size: 11px;
    font-weight: 500;
    backdrop-filter: blur(10px);
  }
}
</style>
