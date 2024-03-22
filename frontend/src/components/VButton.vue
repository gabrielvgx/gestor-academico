<template>
  <v-btn v-bind="$props" :color="color || 'primary'">
    <slot></slot>
  </v-btn>
</template>
<script lang='js'>
export default {
  props: ['color'],
  setup() {}
}
</script>
