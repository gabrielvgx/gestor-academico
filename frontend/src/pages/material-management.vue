<template>
  <Panel :panel="{title: 'Materiais Solicitados'}" hide-actions>
    <template #content>
      <Grid :config="gridConfig" ref="gridRef">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions flex-wrap">
            <v-btn v-if="isTeacher()" prepend-icon="mdi-plus" color="primary" @click="gridAdd">Adicionar</v-btn>
            <!-- <v-btn v-if="isTeacher()" prepend-icon="mdi-delete" color="error" variant="outlined" @click="gridRemove">Remover</v-btn> -->
            <v-btn prepend-icon="mdi-filter" color="primary" variant="outlined" @click="openFilter">Filtro</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal v-if="openedFilter" :modal="{ title: 'Filtro', name: 'planning-filter'}" @close="closeFilter" @confirm="refreshGrid">
        <template #content>
          <PlanningFilter ref="filterRef" :config="{dateLabel: 'Mês da Solicitação'}" />
        </template>
      </Modal>
      <Modal v-if="openedPlanning" :modal="{ title: 'Planejamento', name: 'planning-preview'}" @close="closePlanning" @confirm="savePlanning">
        <template #content>
          <PlanningForm ref="planningForm" :data="formData" />
        </template>
      </Modal>
      <Modal
        v-if="openedRequestForm"
        :modal="{ title: 'Solicitação de Material', name: 'material-request-form', hideFooter: !isTeacher()}"
        @close="closeRequestForm"
        @confirm="confirmRequestForm"
      >
      <template #content>
        <MaterialRequestForm ref="materialRequestForm" :data="requestFormData" @approve="approve" @rejected="rejected"/>
      </template>
      </Modal>
    </template>
  </Panel>
</template>
<script lang="js">

import Grid from '@/components/Grid';
import PlanningFilter from '@/components/PlanningFilter';
import Modal from '@/components/Modal';
import MaterialRequest from '@/controllers/MaterialRequest';
import MaterialRequestForm from './material-request-form.vue';
import Panel from '@/components/Panel';
import { ref } from 'vue';
import Alert from '@/util/Alert';
import PlanningForm from '@/pages/planning-form';
import Token from '@/util/Token';
import StorageHandler from '@/util/StorageHandler';

export default {
  components: {
    Grid,
    PlanningFilter,
    PlanningForm,
    MaterialRequestForm,
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
    async approve() {
      const isValid = await this.$refs.materialRequestForm.isValid();
      if (isValid) {
        const formValue = this.$refs.materialRequestForm.getValue();
        const success = await MaterialRequest.changeStatus(formValue.data.IDREQUISICAO, 'APROVADO', formValue.feedback);
        if (success) {
          this.refreshGrid();
          this.closeRequestForm();
        }
      }
    },
    async rejected() {
      const isValid = await this.$refs.materialRequestForm.isValid();
      if (isValid) {
        const formValue = this.$refs.materialRequestForm.getValue();
        const success = await MaterialRequest.changeStatus(formValue.data.IDREQUISICAO, 'REPROVADO', formValue.feedback);
        if (success) {
          this.refreshGrid();
          this.closeRequestForm();
        }
      }
    },
    closeRequestForm() {
      this.openedRequestForm = false;
      this.requestFormData = {};
    },
    async confirmRequestForm() {
      const isValid = await this.$refs.materialRequestForm.isValid();
      if (isValid) {
        const formValue = this.$refs.materialRequestForm.getValue();
        const success = await MaterialRequest.save(formValue);
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
    closePlanning() {
      this.openedPlanning = false;
    },
    savePlanning() {},
    gridAdd() {
      this.openedRequestForm = true;
    },
    gridRemove() {
      if (this.grid) {
        const rows = this.grid.getSelectedRows();
        if (rows.length) {
          // Material.remove(rows);
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
    const openedRequestForm = ref(false);
    const openedFilter = ref(true);
    const formData = ref({});
    const grid = ref(null);
    const data = ref([]);
    const requestFormData = ref({});
    const filterRef = ref(null);
    const gridRef = ref(null);
    const applyFilter = async () => {
      if (!filterRef.value) {
        const savedFilter = StorageHandler.getFilter('material-management');
        if (savedFilter) {
          data.value = await MaterialRequest.applyFilter(savedFilter);
          openedFilter.value = false;
        }
        return;
      }
      const isValid = await filterRef.value.isValid();
      if (isValid) {
        const filter = filterRef.value.getValue();
        StorageHandler.setFilter('material-management', filter);
        data.value = await MaterialRequest.applyFilter(filter);
        openedFilter.value = false;
      }
    };
    return {
      openedPlanning,
      openedRequestForm,
      requestFormData,
      openedFilter,
      filterRef,
      gridRef,
      formData,
      grid,
      data,
      applyFilter,
      gridConfig: {
        // title: 'Usuários',
        showSelect: false,
        showGroupStatus: true,
        itemValue: 'ID',
        groupBy: [
          { key: 'IDREQUISICAO', order: 'asc' },
        ],
        async onClickGroup({ value }) {
          const result = await MaterialRequest.getRequestDetail(value);
          if (result) {
            requestFormData.value = result;
            openedRequestForm.value = true;
          }
        },
      //   username: Token.getUserName(),
      // reason: null,
      // utilizationDate: null,
      // material: {},
      // schools: [],
      // schoolId: null,
        // async onClickRow(_, params) {
        //   const result = await Planning.getDetail(params);
        //   if (result) {
        //     formData.value = result;
        //     openedPlanning.value = true;
        //   }
        // },
        groupDescription: 'DSJUSTIFICATIVA',
        headers: [
          {
            title: 'Material',
            key: 'NMMATERIAL',
          },
          {
            title: 'Qtd.',
            key: 'QTMATERIAL',
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
.modal.material-request-form {
  max-width: min(100%, 600px);
  max-height: min(100%, 900px);
}
</style>
