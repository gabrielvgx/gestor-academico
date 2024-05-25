<template>
  <Panel :panel="{title: 'Usuários'}">
    <template #content>
      <Grid :config="userGridConfig" ref="grid">
        <template v-slot:header>
          <v-container class="pa-0 ma-0 d-flex header-actions">
            <v-btn prepend-icon="mdi-plus" color="primary" @click="addUser">Adicionar</v-btn>
            <v-btn prepend-icon="mdi-delete" color="error" variant="outlined" @click="removeUser">Remover</v-btn>
          </v-container>
        </template>
      </Grid>
      <Modal v-if="openedModal" :modal="{ title: 'Cadastro de Usuário'}" @close="closeModal" @confirm="confirmUser">
        <template #content>
          <UserForm v-model="userFormData" />
        </template>
      </Modal>
    </template>
  </Panel>
</template>
<script lang="js">

import Grid from '@/components/Grid';
import Request from '@/util/Request';
import UserForm from '@/pages/user-form';
import Modal from '@/components/Modal';
import User from '@/controllers/User';
import Panel from '@/components/Panel';
import { ref } from 'vue';
import Alert from '@/util/Alert';

export default {
  name: 'user',
  components: {
    Grid,
    UserForm,
    Modal,
    Panel,
  },
  methods: {
    addUser() {
      this.openedModal = true;
    },
    removeUser() {
      if (this.grid) {
        const rows = this.grid.getSelectedRows();
        if (rows.length) {
          User.remove(rows);
        } else {
          Alert.showWarn('Selecione ao menos um usuário');
        }
      }
    },
    confirmUser() {
      User.create(this.userFormData).then(() => this.openedModal = false);
    },
    closeModal() {
      this.openedModal = false;
    },
  },
  setup() {
    const openedModal = ref(false);
    const userFormData = ref({});
    const grid = ref(null);
    return {
      openedModal,
      userFormData,
      grid,
      userGridConfig: {
        // title: 'Usuários',
        itemValue: 'ID',
        headers: [
          {
            title: 'Usuário',
            key: 'NMUSUARIO',
          },
          {
            title: 'E-mail',
            key: 'EMAIL',
          },
          {
            title: 'Cargo',
            key: 'CARGO'
          },
        ],
        loadData: async function() {
          // const { page = 1, itemsPerPage = 10, sortBy = [] } = params;
          const { data, total } = await Request.get('/user');
          return { data, total };
        },
      }
    }
  }
}
</script>
<style lang="scss">
</style>
