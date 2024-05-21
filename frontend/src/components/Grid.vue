<template>
  <v-card :title="config.title" flat>
    <template v-slot:text>
      <slot name="header"></slot>
    </template>
    <v-data-table-server
      v-model="selected"
      v-model:items-per-page="itemsPerPage"
      :headers="headers"
      :items="tableData"
      :items-length="totalSize"
      hover
      show-select
      :loading="loading"
      return-object
      :item-value="itemValue"
      @update:options="loadData"
    >

    </v-data-table-server>
  </v-card>
</template>


<script lang="js">

import { ref } from 'vue';

export default {
  name: 'grid',
  props: ['config'],
  data: function() {
    console.log(this.reload());
    return ({
      tableData: [],
    });
  },
  methods: {
    async reload() {
      try {
        const result = await this.loadData();
        this.tableData = result;
      } catch (err) {
        console.error(err.message);
      } finally {
        this.loading = false;
      }
    },
    async loadData(params) {
      if (this.config.loadData) {
        const { data, total } = await this.config.loadData(params);
        this.tableData = data;
        this.totalSize = total;

      } else {
        return [];
      }
    }
  },
  setup(props) {
    const search = ref('');
    const totalSize = ref(0);
    const selected = ref([]);
    // const data = ref([]);
    const loading = ref(true);
    const itemValue = ref(props.config.itemValue || 'id');
    const itemsPerPage = props.config.itemsPerPage || 6;
    const headers = props.config.headers;
    return {
      search,
      getSelectedRows() {
        return selected.value;
      },
      selected,
      loading,
      totalSize,
      headers,
      itemsPerPage,
      itemValue,
    }
  }
}

</script>



<style lang="scss"></style>
