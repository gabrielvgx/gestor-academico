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
      :show-select="showSelect"
      @click:row="onClickRow"
      height="350"
      fixed-header
      :loading="loading"
      return-object
      :item-value="itemValue"
      @update:options="loadData"
    >
    <template v-slot:group-header="{ item, columns, toggleGroup, isGroupOpen }">
      <tr>
        <td :colspan="columns.length">
          <v-btn
            v-if="showGroupActions"
            class="ms-2"
            icon="mdi-delete"
            variant="outlined"
            color="error"
            size="small"
            rounded="lg"
            density="comfortable"
          />
          <v-btn
            :class="hasChildren(item) ? '' : 'hide-expand'"
            :disabled="!hasChildren(item)"
            :icon="isGroupOpen(item) ? '$expand' : '$next'"
            size="small"
            variant="text"
            @click="() => toggleGroup(item)"
          />
          {{ item.items[0].value[groupDescription] }}
          <v-btn
            v-if="showGroupActions"
            class="ms-2"
            icon="mdi-plus"
            variant="flat"
            color="primary"
            size="small"
            rounded="lg"
            density="comfortable"
          />
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
        await this.loadData();
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
    const itemsPerPage = props.config.itemsPerPage || 10;
    const headers = props.config.headers;
    const groupBy = props.config.groupBy || [];
    const groupDescription = props.config.groupDescription || '';
    const hasChildren = props.config.hasChildren || (() => true);
    const onClickRow = props.config.onClickRow || (() => {});
    const showGroupActions = props.config.showGroupActions || false;
    const showSelect = ('showSelect' in props.config) ? props.config.showSelect : true;
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
      hasChildren,
      onClickRow,
      showGroupActions,
      showSelect,
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
.hide-expand {
  opacity: 0;
}
</style>
