<template>
  <div class="search-files-component">
    <div class="search-files-header">
      <i class="fa-solid fa-search"></i>
      <span>文件搜索</span>
    </div>
    <div class="search-files-content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped lang="scss">
.search-files-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.search-files-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;

  i {
    font-size: 16px;
    color: #8e44ad;
    margin-right: 12px;
  }

  span {
    color: #e1e1e1;
    font-weight: 500;
  }
}

.search-files-content {
  padding: 16px 24px;
  color: #e1e1e1;
  line-height: 1.6;
  background: #1e1e1e;
}
</style>
