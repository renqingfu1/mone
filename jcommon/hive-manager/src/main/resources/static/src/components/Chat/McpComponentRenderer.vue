<template>
  <component v-if="componentExists" :is="componentType" v-bind="componentProps">
    <template v-if="hasChildren">
      <McpComponentRenderer
        v-for="(child, index) in componentData.children"
        :key="index"
        :component-data="child"
      />
    </template>
    <template v-else-if="componentData.text">
      <span>{{ componentData.text }}</span>
    </template>
  </component>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { ComponentNode } from '@/utils/xml-component-parser'
import { componentMap } from './mcp-components'

const props = defineProps<{
  componentData: ComponentNode
}>()

const componentExists = computed(() => {
  return componentMap[props.componentData.type] !== undefined
})

const componentType = computed(() => {
  return componentMap[props.componentData.type]
})

const componentProps = computed(() => {
  return props.componentData.props || {}
})

const hasChildren = computed(() => {
  return props.componentData.children && props.componentData.children.length > 0
})
</script>
