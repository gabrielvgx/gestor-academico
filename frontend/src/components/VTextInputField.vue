<template>
  <div v-if="!!labeltext" class="text-subtitle-1 text-medium-emphasis">
    {{ labeltext }}
  </div>
  <v-text-field
    v-bind="$props"
    :density="density || 'compact'"
    :variant="variant || 'outlined'"
    :placeholder="placeholder || ''"
    :prepend-inner-icon="prependInnerIcon || ''"
    :rules="rules || []"
  >
    <slot></slot>
  </v-text-field>
</template>
<script lang='js'>
export default {
  props: ['density', 'variant', 'labeltext', 'placeholder', 'prepend-inner-icon', 'rules'],
  setup() {
  }
}
</script>
