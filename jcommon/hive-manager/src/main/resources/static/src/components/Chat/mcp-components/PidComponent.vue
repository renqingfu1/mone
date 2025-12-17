<template>
  <span class="pid-buttons-container process-running" :data-pid="pid" title="进程控制面板">
    <button 
      class="pid-kill-button" 
      :data-pid="pid" 
      data-action="kill" 
      :title="`终止进程 PID: ${pid}`"
      @click="handleKill"
    >
      <i class="fa-solid fa-power-off"></i>
      <span>杀死进程</span>
      <small>{{ pid }}</small>
    </button>
    <button 
      class="pid-detach-button" 
      :data-pid="pid" 
      data-action="detach" 
      :title="`将进程 PID: ${pid} 转为后台运行`"
      @click="handleDetach"
    >
      <i class="fa-solid fa-arrow-up-right-from-square"></i>
      <span>后台运行</span>
      <small>{{ pid }}</small>
    </button>
  </span>
</template>

<script setup lang="ts">
const props = defineProps<{
  pid?: string
}>()

const emit = defineEmits<{
  kill: [pid: string]
  detach: [pid: string]
}>()

const handleKill = () => {
  if (props.pid) {
    emit('kill', props.pid)
  }
}

const handleDetach = () => {
  if (props.pid) {
    emit('detach', props.pid)
  }
}
</script>

<style scoped lang="scss">
.pid-buttons-container {
  display: inline-flex;
  gap: 10px;
  margin: 8px 6px;
  align-items: center;
  padding: 6px 10px;
  background: rgba(45, 45, 45, 0.5);
  border-radius: 10px;
  border: 1px solid rgba(61, 61, 61, 0.3);
  backdrop-filter: blur(4px);
  transition: all 0.3s ease;
  position: relative;

  &::before {
    content: '';
    position: absolute;
    left: -2px;
    top: 50%;
    transform: translateY(-50%);
    width: 6px;
    height: 20px;
    background: linear-gradient(180deg, #67c23a 0%, #00b3ff 100%);
    border-radius: 3px;
    opacity: 0.8;
    animation: pidStatusPulse 2s infinite ease-in-out;
  }

  &.process-running::before {
    background: linear-gradient(180deg, #67c23a 0%, lighten(#67c23a, 10%) 100%);
    animation: pidRunningPulse 1.5s infinite ease-in-out;
  }
}

.pid-kill-button,
.pid-detach-button {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: white;
  border: none;
  border-radius: 8px;
  padding: 8px 14px;
  font-size: 0.85em;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-decoration: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

.pid-kill-button {
  background: linear-gradient(135deg, #e74c3c 0%, darken(#e74c3c, 15%) 100%);
}

.pid-detach-button {
  background: linear-gradient(135deg, #00b3ff 0%, darken(#00b3ff, 15%) 100%);
}

.pid-kill-button:hover,
.pid-detach-button:hover {
  transform: translateY(-2px) scale(1.02);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.5);
}

small {
  font-size: 0.75em;
  opacity: 0.8;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.15);
  padding: 2px 6px;
  border-radius: 4px;
  margin-left: 4px;
}

@keyframes pidStatusPulse {
  0%, 100% {
    opacity: 0.6;
    transform: translateY(-50%) scaleY(1);
  }
  50% {
    opacity: 1;
    transform: translateY(-50%) scaleY(1.2);
  }
}

@keyframes pidRunningPulse {
  0%, 100% {
    opacity: 0.8;
    filter: brightness(1);
  }
  50% {
    opacity: 1;
    filter: brightness(1.2);
  }
}
</style>
