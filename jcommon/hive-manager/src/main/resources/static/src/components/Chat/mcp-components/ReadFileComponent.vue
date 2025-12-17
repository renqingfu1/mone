<template>
  <div class="read-file-component">
    <div class="read-file-header">
      <i class="fa-solid fa-file-text"></i>
      <span>读取文件</span>
    </div>
    <div class="read-file-content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped lang="scss">
.read-file-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.read-file-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;

  i {
    font-size: 16px;
    color: #4a90e2;
    margin-right: 12px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
  }
}

.read-file-content {
  padding: 16px 24px;
  color: #e1e1e1;
  line-height: 1.6;
  background: #1e1e1e;
}
</style>
