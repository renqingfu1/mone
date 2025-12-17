<template>
  <div class="download-file-component">
    <div class="file-url-header">
      <i class="fa-solid fa-file"></i>
      <span>文件下载</span>
    </div>
    <div class="file-url-content">
      <a 
        class="file-url-link" 
        href="javascript:;" 
        :data-name="fileName" 
        :data-url="fileUrl"
        @click="handleDownload"
      >
        {{ fileName }}
      </a>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  fileName?: string
  fileUrl?: string
}>()

const handleDownload = (e: Event) => {
  e.preventDefault()
  if (props.fileUrl) {
    const urlObj = new URL(props.fileUrl)
    const params = new URLSearchParams(urlObj.search)
    const form = document.createElement('form')
    form.method = 'GET'
    form.action = urlObj.origin + urlObj.pathname
    form.target = '_blank'
    form.style.display = 'none'
    params.forEach((value, key) => {
      const input = document.createElement('input')
      input.type = 'hidden'
      input.name = key
      input.value = value
      form.appendChild(input)
    })
    document.body.appendChild(form)
    form.submit()
    setTimeout(() => {
      document.body.removeChild(form)
    }, 100)
  }
}
</script>

<style scoped lang="scss">
.download-file-component {
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.file-url-header {
  display: flex;
  align-items: center;
  padding: 20px 15px;
  background: rgba(0, 0, 0, 0.5);
  border-bottom: 1px solid #3d3d3d;
  cursor: pointer;
  user-select: none;

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

.file-url-content {
  padding: 16px 24px;
  border-top: 1px solid #3d3d3d;
  display: flex;
  color: #e1e1e1;
  line-height: 1.6;
  align-items: center;
  justify-content: flex-start;
}

.file-url-link {
  color: #00b3ff;
  text-decoration: none;
  cursor: pointer;
  transition: color 0.2s;

  &:hover {
    color: #4dabf7;
    text-decoration: underline;
  }
}
</style>
