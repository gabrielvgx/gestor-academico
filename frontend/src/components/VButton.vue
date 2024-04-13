<template>
  <v-btn v-bind="$props" :color="color || 'primary'" variant="flat">
    <slot></slot>
  </v-btn>
</template>
<script lang='js'>
export default {
  props: ['color'],
  setup() {}
}
</script>
