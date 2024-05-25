<template>
  <Panel :panel="{title: 'Materiais'}">
    <template #content>
      <Grid :config="gridConfig" ref="grid">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions">
            <v-btn prepend-icon="mdi-plus" color="primary" @click="gridAdd">Adicionar</v-btn>
            <v-btn prepend-icon="mdi-delete" color="error" variant="outlined" @click="gridRemove">Remover</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal v-if="openedModal" :modal="{ title: 'Cadastro de Material'}" @close="closeModal" @confirm="modalConfirm">
        <template #content>
          <MaterialForm v-model="formData" />
        </template>
      </Modal>
    </template>
  </Panel>
</template>
<script lang="js">

import Grid from '@/components/Grid';
import Request from '@/util/Request';
import MaterialForm from '@/pages/material-form';
import Modal from '@/components/Modal';
import Material from '@/controllers/Material';
import Panel from '@/components/Panel';
import { ref } from 'vue';
import Alert from '@/util/Alert';

export default {
  components: {
    Grid,
    MaterialForm,
    Modal,
    Panel,
  },
  methods: {
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
    const formData = ref({});
    const grid = ref(null);
    return {
      openedModal,
      formData,
      grid,
      gridConfig: {
        // title: 'Usuários',
        itemValue: 'ID',
        headers: [
          {
            title: 'Material',
            key: 'NMMATERIAL',
          },
        ],
        loadData: async function() {
          // const { page = 1, itemsPerPage = 10, sortBy = [] } = params;
          const { data, total } = await Request.get('/material');
          return { data, total };
        },
      }
    }
  }
}
</script>
<style lang="scss">
</style>
