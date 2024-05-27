<template>
  <Panel :panel="{title: 'Planejamentos'}" hide-actions>
    <template #content>
      <Grid v-if="showGrid" :config="gridConfig" ref="grid">
        <!-- <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions">
            <v-btn prepend-icon="mdi-plus" color="primary" @click="gridAdd">Adicionar</v-btn>
            <v-btn prepend-icon="mdi-delete" color="error" variant="outlined" @click="gridRemove">Remover</v-btn>
          </v-container>
        </template> -->
      </Grid>
      <Modal v-if="openedFilter" :modal="{ title: 'Filtro', name: 'planning-filter'}" @close="closeFilter" @confirm="applyFilter">
        <template #content>
          <PlanningFilter ref="filter" />
        </template>
      </Modal>
    </template>
  </Panel>
</template>
<script lang="js">

import Grid from '@/components/Grid';
import PlanningFilter from '@/components/PlanningFilter';
import Modal from '@/components/Modal';
import Material from '@/controllers/Material';
import Panel from '@/components/Panel';
import { ref } from 'vue';
import Alert from '@/util/Alert';
import Planning from '@/controllers/Planning';

export default {
  components: {
    Grid,
    PlanningFilter,
    Modal,
    Panel,
  },
  methods: {
    closeFilter() {
      this.openedFilter = false;
    },
    async applyFilter() {
      const isValid = await this.$refs.filter.isValid();
      if (isValid) {
        const filter = this.$refs.filter.getValue();
        this.data = await Planning.applyFilter(filter);
        this.openedFilter = false;
        this.showGrid = true;
      }
    },
    gridAdd() {
      this.openedModal = true;
    },
    gridRemove() {
      if (this.grid) {
        const rows = this.grid.getSelectedRows();
        if (rows.length) {
          Material.remove(rows);
        } else {
          Alert.showWarn('Selecione ao menos um item');
        }
      }
    },
    modalConfirm() {
      Material.create(this.formData).then(() => this.openedModal = false);
    },
    closeModal() {
      this.openedModal = false;
    },
  },
  setup() {
    const openedModal = ref(false);
    const openedFilter = ref(true);
    const formData = ref({});
    const showGrid = ref(false);
    const grid = ref(null);
    const data = ref([]);
    return {
      openedModal,
      openedFilter,
      formData,
      grid,
      showGrid,
      data,
      gridConfig: {
        // title: 'Usuários',
        showSelect: false,
        itemValue: 'ID',
        groupBy: [
          { key: 'IDTURMA', order: 'asc' },
        ],
        groupDescription: 'NMTURMA',
        headers: [
          {
            title: 'Período',
            key: 'PERIODO',
          },
        ],
        loadData: async function() {
          return { data: data.value, total: 1 };
          // const { page = 1, itemsPerPage = 10, sortBy = [] } = params;
          // const { data, total } = await Request.get('/material');
          // return { data, total };
        },
      }
    }
  }
}
</script>
<style lang="scss">
.modal.planning-filter {
  max-width: min(100%, 500px);
  max-height: min(100%, 400px);
}
</style>
