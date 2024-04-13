<template>
  <v-container class='ma-0 pa-0 w-100 h-100'>
    <v-img src="@/assets/background.svg" cover class='pa-0 login-bg'></v-img>
    <v-form class="login-form" ref="form">
      <v-card class="mx-auto pa-12 pb-8" elevation="8">
        <v-img src="@/assets/logo.svg" class="mb-12"></v-img>

        <div class="text-subtitle-1 text-medium-emphasis">E-mail</div>
        <v-text-field
          tabindex="1"
          v-model="formData.email"
          :rules="rules"
          density="compact"
          placeholder="Digite seu e-mail"
          prepend-inner-icon="mdi-email-outline"
          variant="outlined"
          autocomplete="username"
        ></v-text-field>

        <div class="text-subtitle-1 text-medium-emphasis d-flex align-center justify-space-between">
          Senha

          <a tabindex="4" class="text-caption text-decoration-none text-primary" href="#" rel="noopener noreferrer" target="_blank">
            Esqueceu sua senha?</a>
        </div>

        <v-text-field
          tabindex="2"
          v-model="formData.password"
          :rules="rules"
          :append-inner-icon="visible ? 'mdi-eye' : 'mdi-eye-off'"
          :type="visible ? 'text' : 'password'"
          density="compact"
          placeholder="Digite sua senha"
          prepend-inner-icon="mdi-lock-outline"
          variant="outlined"
          @click:append-inner="visible = !visible"
          autocomplete="current-password"
        ></v-text-field>

        <VButton tabindex="3" class="mt-8" size="large" block @click="login">
          Entrar
        </VButton>

      </v-card>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import VButton from '@/components/VButton.vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';

export default {
  name: 'login-page',
  components: {
    VButton,
  },
  methods: {
    async login() {
      try {
        const { valid } = await this.$refs.form.validate();
        if (!valid) return;
        await Login.auth(this.formData);
        this.$router.push({ path: 'school-select' });
      } catch (err) {
        console.error(err);
      }
    },
  },
  setup() {
    const visible = ref(false);
    const formData = ref({
      email: null,
      password: null,
    });
    return {
      visible,
      rules: [
        Rule.required(),
      ],
      formData,
    }
  }
}
</script>
<style lang="scss">
.login-bg {
  position: absolute;
  width: 100vw;
  height: 100vh;
}
.login-form {
  position: absolute;
  right: 0;
  top: 0;
  width: 30%;
  height: 100% !important;
  .v-card {
    height: 100%;
  }
}
.v-container {
  max-width:none !important;
}

/* Estilos para telas pequenas (celulares em orientação retrato) */
@media only screen and (max-width: 600px) {
  .login-form {
    width: 100%;
  }
}

/* Estilos para telas médias (tablets em orientação retrato) */
@media only screen and (min-width: 601px) and (max-width: 992px) {
  .login-form {
    width: 60%;
  }
}

/* Estilos para telas grandes (desktops e tablets em orientação paisagem) */
@media only screen and (min-width: 993px) and (max-width: 1199px) {
  .login-form {
    width: 40%;
  }
}
@media only screen and (min-width: 1200px) {
  .login-form {
    max-width: 500px;
  }
}
</style>
