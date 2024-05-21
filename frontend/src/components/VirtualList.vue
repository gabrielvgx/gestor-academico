<template>
  <v-data-table-virtual
    :headers="headers"
    :items="data"
    :item-value="itemValue"
    fixed-header
    height="400"
  >
  <!-- <slot name="content"></slot> -->
  <template #item.QUANTITY="{ item }">
    <!-- <v-number-input control-variant="default"></v-number-input> -->
    <v-container v-if="!!item.QUANTITY" class="pa-0 pe-3">
      <NumberInput @change="({ value }) => changeItemQuantity(item, value)"/>
    </v-container>
    <v-btn
      v-else
      icon="mdi-plus"
      flat
      color="green"
      rounded="0"
      variant="text"
      @click="() => changeItemQuantity(item, 1)"
    ></v-btn>
      <!-- <v-card style="width: 100px; height: 50px;"> -->
        <!-- <v-number-input
          control-variant="split"
        ></v-number-input> -->
      <!-- </v-card> -->
    </template>
  </v-data-table-virtual>
</template>
<script lang="js">
import NumberInput from '@/components/NumberInput';

export default {
  props: ['config'],
  components: {
    NumberInput,
  },
  emits: ['changeItemQuantity'],
  methods: {
    changeItemQuantity(item, quantity) {
      this.$emit('changeItemQuantity', { item, quantity });
      item.QUANTITY = quantity;
    }
  },
  setup(props) {
    const { headers, data, itemValue = 'ID' } = props.config;
    return {
      headers,
      data,
      itemValue,
    }
  }
}
</script>
<style lang="scss"></style>
