<template>
  <Panel :panel="{title: 'Planejamentos'}">
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
          <MaterialForm ref="addMaterialRef" v-model="formData" />
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
import { EventModule } from '@/util/EventModule';
import { onUnmounted } from 'vue';

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
          EventModule.emit('confirmMessage', { event: 'remove-material', message: `Confirma a exclusão de ${rows.length} materiais?`})
        } else {
          Alert.showWarn('Selecione ao menos um item');
        }
      }
    },
    async modalConfirm() {
      const isValid = await this.$refs.addMaterialRef.isValid();
      if (isValid) {
        const data = this.$refs.addMaterialRef.getValue();
        const success =  await Material.create(data);
        if (success) {
          this.openedModal = false;
          this.grid.reload();
        }
      }
    },
    closeModal() {
      this.openedModal = false;
    },
  },
  setup() {
    const openedModal = ref(false);
    const formData = ref({});
    const grid = ref(null);
    const removeMaterial = async () => {
      const success = await Material.remove(grid.value.getSelectedRows());
      if (success) {
        grid.value.reload();
      }
    }
    EventModule.on('remove-material', removeMaterial);
    onUnmounted(() => {
      EventModule.off('remove-material', removeMaterial);
    })
    return {
      openedModal,
      formData,
      grid,
      removeMaterial,
      gridConfig: {
        // title: 'Usuários',
        itemValue: 'ID',
        headers: [
          {
            title: 'Material',
            key: 'NMMATERIAL',
          },
          {
            title: 'Descrição',
            key: 'DSMATERIAL',
          },
        ],
        loadData: async function() {
          // const { page = 1, itemsPerPage = 10, sortBy = [] } = params;
          const { data, total } = await Request.get('/planning');
          return { data, total };
        },
      }
    }
  }
}
</script>
<style lang="scss">
</style>
