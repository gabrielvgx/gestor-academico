<template>
  <VirtualList
    v-if="loaded"
    :config="config"
    @changeItemQuantity="(params) => $emit('changeItemQuantity', params)"
  />
</template>
<script lang="js">
import { ref } from 'vue';
import VirtualList from './VirtualList.vue';
import Material from '@/controllers/Material';

export default {
  components: {
    VirtualList,
  },
  emits: ['changeItemQuantity'],
  setup() {
    const loaded = ref(false);
    const config = ref({
      headers: [
        {
          key: 'NMMATERIAL',
          title: 'Nome',
        },
        {
          key: 'QUANTITY',
          title: 'Qtd.',
          align: 'end',
          width: '130',
          cellProps: {
            style: {
              padding: 0,
            }
          }
        }
      ],
      data: [],
    });
    Material.list().then(result => {
      config.value.data = result.data;
      loaded.value = true;
    });
    return {
      config,
      loaded,
    }
  }
}
</script>
<style lang="scss"></style>
