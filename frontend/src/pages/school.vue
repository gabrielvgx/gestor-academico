<template>
  <Panel :panel="{title: 'Escolas'}">
    <template #content>
      <Grid :config="gridConfig" ref="grid">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions">
            <v-btn prepend-icon="mdi-plus" color="primary" @click="addGridItem">Adicionar</v-btn>
            <v-btn prepend-icon="mdi-delete" color="error" variant="outlined" @click="removeGridItem">Remover</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal
        v-if="openedModal"
        :modal="{ title: 'Cadastro de Escola / Turmas'}"
        @close="closeModal"
        @confirm="confirmModal"
      >
        <template #content>
          <SchoolForm ref="formRef" v-model="formData" />
        </template>
      </Modal>
    </template>
  </Panel>
</template>
<script lang="js">
import Panel from '@/components/Panel';
import Modal from '@/components/Modal';
import Grid from '@/components/Grid';
import { ref } from 'vue';
import Request from '@/util/Request';
import SchoolForm from '@/pages/school-form';

export default {
  components: {
    Panel,
    Modal,
    Grid,
    SchoolForm,
  },
  methods: {
    addGridItem() {
      this.openedModal = true;
    },
    removeGridItem() {},
    closeModal() {
      this.openedModal = false;
    },
    async confirmModal() {
      const isValid = await this.$refs.formRef.validate();
      if (isValid) {
        const formData = this.$refs.formRef.getFormData();
        console.log(formData);
      }
    },
  },
  setup() {
    const formData = ref({});
    const openedModal = ref(false);
    const gridConfig = {
      itemValue: 'ID',
      groupBy: [
        { key: 'ID', order: 'asc' },
        // { key: 'NMESCOLA', order: 'asc' },
      ],
      groupDescription: 'NMESCOLA',
      hasChildren(row){
        return row.items.some(item => item.value.IDTURMA);
      },
      headers: [
        {
          title: 'Turma',
          key: 'NMTURMA',
        }
      ],
      loadData: async function() {
        // const { page = 1, itemsPerPage = 10, sortBy = [] } = params;
        const { data, total } = await Request.get('/school-and-class');
        return { data, total };
      },
    };
    return {
      gridConfig,
      formData,
      openedModal,
    }
  }
}

</script>
<style lang="scss"></style>
