<template>
  <v-text-field
    class="custom-number-input"
    v-model="value"
    variant="plain"
    hide-details
    readonly
    inset
    @update:modelValue="onChange"
  >
    <template v-slot:prepend>
      <v-icon :color="this.value === 0 ? 'gray' : 'red'" @click="subtract">
        mdi-minus
      </v-icon>
    </template>
    <template v-slot:append>
      <v-icon :color="this.value === 99 ? 'gray' : 'green'" @click="add">
        mdi-plus
      </v-icon>
    </template>
  </v-text-field>
</template>
<script lang="js">
import { ref } from 'vue';
export default {
  emits: ['change'],
  methods: {
    add() {
      if (this.value < 99) {
        this.value++;
        this.onChange(this.value);
      }
    },
    subtract() {
      if (this.value > 0) {
        this.value--;
        this.onChange(this.value);
      }
    },
    onChange(value) {
      this.$emit('change', { value });
    }
  },
  setup() {
    const value = ref(1);
    return {
      value,
    }
  }
}
</script>
<style lang="scss">
.custom-number-input {
  .v-input__prepend, .v-input__append {
    padding: 0 !important;
    align-items: center !important;
  }
  .v-input__control input {
    text-align: center;
  }
}
</style>
