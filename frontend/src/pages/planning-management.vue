<template>
  <Panel :panel="{title: 'Planejamentos'}" hide-actions>
    <template #content>
      <Grid :config="gridConfig" ref="gridRef">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions">
            <v-btn v-if="isTeacher()" prepend-icon="mdi-plus" color="primary" @click="gridAdd">Adicionar</v-btn>
            <!-- <v-btn v-if="isTeacher()" prepend-icon="mdi-delete" color="error" variant="outlined" @click="gridRemove">Remover</v-btn> -->
            <v-btn prepend-icon="mdi-filter" color="primary" variant="outlined" @click="openFilter">Filtro</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal v-if="openedFilter" :modal="{ title: 'Filtro', name: 'planning-filter'}" @close="closeFilter" @confirm="refreshGrid">
        <template #content>
          <PlanningFilter ref="filterRef" :config="{dateLabel: 'Mês do Planejamento'}" />
        </template>
      </Modal>
      <Modal v-if="openedPlanning" :modal="{ title: 'Planejamento', name: 'planning-preview'}" @close="closePlanning" @confirm="savePlanning">
        <template #content>
          <PlanningForm ref="planningForm" :data="formData" />
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
import PlanningForm from '@/pages/planning-form';
import Token from '@/util/Token';

export default {
  components: {
    Grid,
    PlanningFilter,
    PlanningForm,
    Modal,
    Panel,
  },
  methods: {
    isTeacher() {
      return Token.getUserProfile() === 'TEACHER';
    },
    openFilter() {
      this.openedFilter = true;
    },
    closeFilter() {
      this.openedFilter = false;
    },
    closePlanning() {
      this.openedPlanning = false;
      this.formData = {};
    },
    async savePlanning() {
      const isValid = await this.$refs.planningForm.isValid();
      if (isValid) {
        const formValue = this.$refs.planningForm.getValue();
        const success = await Planning.save(formValue);
        if (success) {
          this.formData = {};
          this.openedPlanning = false;
        }
      }
    },
    gridAdd() {
      this.openedPlanning = true;
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
    async refreshGrid() {
      this.gridRef.reload();
    }
  },
  setup() {
    const openedPlanning = ref(false);
    const openedFilter = ref(true);
    const formData = ref({});
    const showGrid = ref(false);
    const grid = ref(null);
    const data = ref([]);
    const filterRef = ref(null);
    const gridRef = ref(null);
    const applyFilter = async () => {
      if (!filterRef.value) return;
      const isValid = await filterRef.value.isValid();
      if (isValid) {
        const filter = filterRef.value.getValue();
        data.value = await Planning.applyFilter(filter);
        openedFilter.value = false;
        showGrid.value = true;
      }
    };
    return {
      openedPlanning,
      openedFilter,
      filterRef,
      gridRef,
      formData,
      grid,
      showGrid,
      data,
      applyFilter,
      gridConfig: {
        // title: 'Usuários',
        showSelect: false,
        itemValue: 'ID',
        groupBy: [
          { key: 'IDTURMA', order: 'asc' },
        ],
        async onClickRow(_, params) {
          const result = await Planning.getDetail(params);
          if (result) {
            formData.value = result;
            openedPlanning.value = true;
          }
        },
        groupDescription: 'NMTURMA',
        headers: [
          {
            title: 'Período',
            key: 'PERIODO',
          },
          {
            title: 'Status',
            key: 'STATUS',
          },
        ],
        loadData: async function() {
          await applyFilter();
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
