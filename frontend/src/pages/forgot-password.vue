<template>
  <LoginCard>
    <template #content>
      <h3 class="text-center">Recuperação de Acesso</h3>
      <div class="d-flex w-100 mb-3">
        <span class="description text-center w-100">Informe o seu e-mail cadastrado na plataforma</span>
      </div>
      <div>
        <div class="text-subtitle-1 required">E-mail</div>
        <v-text-field
          ref="emailField"
          :rules="rules"
          v-model="email"
          variant="outlined"
          placeholder="exemplo@exemplo.com"
          density="compact"
        />
      </div>
      <div class="d-flex justify-center">
        <v-btn
          color="primary"
          class="w-100"
          :loading="loading"
          @click="sendOTP"
        >Enviar</v-btn>
      </div>
    </template>
  </LoginCard>
</template>

<script lang="js">

import LoginCard from '@/components/LoginCard';
import Login from '@/controllers/Login';
import Rule from '@/util/Rule';
import { ref } from 'vue';
import StorageHandler from '@/util/StorageHandler';

export default {
  components: {
    LoginCard,
  },
  methods: {
    async sendOTP() {
      const result = await this.$refs.emailField.validate();
      const isValid = result.length === 0;
      if (isValid) {
        this.loading = true;
        const success = await Login.forgotPassword({ email: this.email }).finally(() => this.loading = false);
        if (success) {
          StorageHandler.setForgotPassUser(this.email);
          this.$router.push({ path: '/otp' })
        }
      }
    }
  },
  setup() {
    const email = ref('');
    const loading = ref(false);
    return {
      email,
      loading,
      rules: [Rule.required()]
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
