<template>
  <div class="ask-followup-component">
    <div class="followup-header">
      <i class="fa-solid fa-question"></i>
      <span>追问</span>
    </div>
    <div class="followup-content">
      <slot>
        <div v-if="question" class="question-text">{{ question }}</div>
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  question?: string
}>()
</script>

<style scoped lang="scss">
.ask-followup-component {
  display: flex;
  flex-direction: column;
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: transparent;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
  overflow: hidden;
}

.followup-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;

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

.followup-content {
  padding: 16px 24px;
  color: #e1e1e1;
  line-height: 1.6;
  background: #1e1e1e;
}

.question-text {
  white-space: pre-wrap;
  word-wrap: break-word;
}
</style>
