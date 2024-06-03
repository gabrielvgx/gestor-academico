<template>
  <Panel :panel="{title: 'Registro Alimentar'}" hide-actions>
    <template #content>
      <Grid :config="gridConfig" ref="gridRef">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions flex-wrap">
            <v-btn v-if="isKitchen()" prepend-icon="mdi-plus" color="primary" @click="gridAdd">Adicionar</v-btn>
            <!-- <v-btn v-if="isTeacher()" prepend-icon="mdi-delete" color="error" variant="outlined" @click="gridRemove">Remover</v-btn> -->
            <v-btn prepend-icon="mdi-filter" color="primary" variant="outlined" @click="openFilter">Filtro</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal v-if="openedFilter" :modal="{ title: 'Filtro', name: 'food-filter'}" @close="closeFilter" @confirm="refreshGrid">
        <template #content>
          <PlanningFilter ref="filterRef" :config="{dateLabel: 'Mês'}" />
        </template>
      </Modal>
      <Modal v-if="openedForm" :modal="{ title: 'Registro Alimentar', name: 'record-modal'}" @close="closeForm" @confirm="saveForm">
        <template #content>
          <FoodForm ref="foodForm" :data="formData" />
        </template>
      </Modal>
      <!-- <Modal
        v-if="openedRequestForm"
        :modal="{ title: 'Solicitação de Material', name: 'material-request-form', hideFooter: !isTeacher()}"
        @close="closeRequestForm"
        @confirm="confirmRequestForm"
      >
      <template #content>
        <MaterialRequestForm ref="materialRequestForm" :data="requestFormData" @approve="approve" @rejected="rejected"/>
      </template>
      </Modal> -->
    </template>
  </Panel>
</template>
<script lang="js">

import Grid from '@/components/Grid';
import PlanningFilter from '@/components/PlanningFilter';
import Modal from '@/components/Modal';
import Food from '@/controllers/Food';
import Panel from '@/components/Panel';
import { ref } from 'vue';
import Token from '@/util/Token';
import StorageHandler from '@/util/StorageHandler';

export default {
  components: {
    Grid,
    PlanningFilter,
    Modal,
    Panel,
  },
  methods: {
    isKitchen() {
      return Token.getUserProfile() === 'KITCHEN';
    },
    openFilter() {
      this.openedFilter = true;
    },
    closeRequestForm() {
      this.openedRequestForm = false;
      this.requestFormData = {};
    },
    async confirmRequestForm() {
      const isValid = await this.$refs.materialRequestForm.isValid();
      if (isValid) {
        const formValue = this.$refs.materialRequestForm.getValue();
        const success = await Food.save(formValue);
        if (success) {
          this.$refs.gridRef.reload();
          this.openedRequestForm = false;
          this.requestFormData = {};
        }
      }
    },
    closeFilter() {
      this.openedFilter = false;
    },
    closeForm() {
      this.openedForm = false;
    },
    savePlanning() {},
    gridAdd() {
      this.openedForm = true;
    },
    async refreshGrid() {
      this.gridRef.reload();
    }
  },
  setup() {
    const openedForm = ref(false);
    const openedFilter = ref(true);
    const formData = ref({});
    const grid = ref(null);
    const data = ref([]);
    const filterRef = ref(null);
    const gridRef = ref(null);
    const applyFilter = async () => {
      if (!filterRef.value) {
        const savedFilter = StorageHandler.getFilter('food-management');
        if (savedFilter) {
          data.value = await Food.applyFilter(savedFilter);
          openedFilter.value = false;
        }
        return;
      }
      const isValid = await filterRef.value.isValid();
      if (isValid) {
        const filter = filterRef.value.getValue();
        StorageHandler.setFilter('food-management', filter);
        data.value = await Food.applyFilter(filter);
        openedFilter.value = false;
      }
    };
    return {
      openedFilter,
      openedForm,
      filterRef,
      gridRef,
      formData,
      grid,
      data,
      applyFilter,
      gridConfig: {
        // title: 'Usuários',
        showSelect: false,
        showGroupStatus: false,
        itemValue: 'ID',
        groupBy: [
          { key: 'DTREFEICAO', order: 'asc' },
        ],
        // async onClickRow(_, params) {
        //   const result = await Planning.getDetail(params);
        //   if (result) {
        //     formData.value = result;
        //     openedPlanning.value = true;
        //   }
        // },
        groupDescription: 'DTREFEICAO',
        headers: [
          {
            title: 'Tipo de Refeição',
            key: 'NMREFEICAO',
          },
          {
            title: 'Comensais',
            key: 'COMENSAIS',
          },
          {
            title: 'Resto Ing. (Kg)',
            key: 'RESTOINGESTA',
          },
          {
            title: 'Sobra Limpa (Kg)',
            key: 'SOBRALIMPA',
          },
          {
            title: 'Sobra Suja (Kg)',
            key: 'SOBRASUJA',
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
.modal.food-filter {
  max-width: min(100%, 500px);
  max-height: min(100%, 400px);
}
.modal.material-request-form {
  max-width: min(100%, 600px);
  max-height: min(100%, 900px);
}
</style>
