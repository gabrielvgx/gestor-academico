<template>
  <LoginCard>
    <template #content>
      <h3 class="text-center">Validação de Acesso</h3>
      <div class="d-flex w-100 my-3 align-center justify-center">
        <span class="description text-center">Informe o código enviado para o e-mail gab****@gmail.com</span>
      </div>
      <v-otp-input v-model="otp" @finish="submitCode"></v-otp-input>
      <div class="d-flex w-100 mb-6 align-center justify-center">
        <span class="description text-center">Não recebeu o código?</span>
        <v-btn
          variant="text"
          style="text-transform: none"
          density="compact"
          color="primary"
          size="small"
        >
          Enviar novamente
        </v-btn>
      </div>
      <div class="d-flex justify-center">
        <v-btn color="primary" class="w-100" :loading="loading">Verificar</v-btn>
      </div>
    </template>
  </LoginCard>
</template>

<script lang="js">

import LoginCard from '@/components/LoginCard';
import Login from '@/controllers/Login';
import StorageHandler from '@/util/StorageHandler';

import { ref } from 'vue';

export default {
  components: {
    LoginCard,
  },
  methods: {
    async submitCode() {
      try {
        this.loading = true;
        const tokenNewPass = await Login.submitCode(this.otp).finally(() => this.loading = false);
        if (tokenNewPass) {
          StorageHandler.setNewPassToken(tokenNewPass);
          this.$router.push({ path: '/new-password' });
        }
        this.loading = true;
      } finally {
        this.loading = false;
      }
    }
  },
  setup() {
    const otp = ref('');
    const loading = ref(false);
    return {
      otp,
      loading,
    }
  }
}

</script>

<style lang="scss">
.description {
  font-size: 0.9rem;
  color: #999999;
}
</style>
