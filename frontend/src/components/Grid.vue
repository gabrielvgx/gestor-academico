<template>
  <v-card :title="config.title" class="ma-0 card-grid">
    <template v-slot:text>
      <slot name="header"></slot>
    </template>
    <v-data-table-server
      class="table-grid"
      v-model="selected"
      v-model:items-per-page="itemsPerPage"
      :headers="headers"
      :items="tableData"
      :items-length="totalSize"
      :group-by="groupBy"
      hover
      show-select
      height="300"
      fixed-header
      :loading="loading"
      return-object
      :item-value="itemValue"
      @update:options="loadData"
    >
    <template v-slot:group-header="{ item, columns, toggleGroup, isGroupOpen }">
      <tr>
        <td :colspan="columns.length">
          <VBtn
            :icon="isGroupOpen(item) ? '$expand' : '$next'"
            size="small"
            variant="text"
            @click="() => toggleGroup(item)"
          ></VBtn>
          {{ item.items[0].value[groupDescription] }}
        </td>
      </tr>
    </template>
    </v-data-table-server>
  </v-card>
</template>


<script lang="js">

import { ref } from 'vue';

export default {
  name: 'grid',
  props: ['config'],
  data: function() {
    return ({
      tableData: [],
    });
  },
  methods: {
    async reload() {
      try {
        this.loading = true;
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
    const loading = ref(false);
    const itemValue = ref(props.config.itemValue || 'id');
    const itemsPerPage = props.config.itemsPerPage || 6;
    const headers = props.config.headers;
    const groupBy = props.config.groupBy || [];
    const groupDescription = props.config.groupDescription || '';
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
      groupBy,
      groupDescription,
    }
  }
}

</script>



<style lang="scss">
// .card-grid
.table-grid
 {
  max-height: 80%;
  overflow-y: auto;
}
</style>
