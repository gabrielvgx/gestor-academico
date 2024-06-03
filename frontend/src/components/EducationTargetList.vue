<template>
  <VirtualList
    ref="virtuaListRef"
    :config="config"
  />
</template>
<script lang="js">
import { ref } from 'vue';
import VirtualList from './VirtualList.vue';

export default {
  components: {
    VirtualList,
  },
  props: ['data'],
  methods: {
    getSelectedItems() {
      return this.$refs.virtuaListRef.getSelectedItems();
    }
  },
  setup(props) {
    const config = ref({
      headers: [
        {
          key: 'CODBNCC',
          title: 'Cód.',
        },
        {
          key: 'DSFAIXAETARIA',
          title: 'Faixa etária',
        },
        {
          key: 'NMCAMPOEXP',
          title: 'Campo exp.',
        },
        {
          key: 'DSOBJETIVO',
          title: 'Descrição',
          // align: 'end',
          // width: '130',
          // cellProps: {
          //   style: {
          //     padding: 0,
          //   }
          // }
        },
        {
          key: 'SELECTED',
          title: '',
        }
      ],
      data: props.data,
    });
    return {
      config,
    }
  }
}
</script>
<style lang="scss"></style>
