<template>
  <LoginCard>
    <template #content>
      <h3 class="text-center">{{ title }}</h3>
      <div class="d-flex w-100 my-3">
        <span class="description text-center">Informe a senha que deseja utilizar para acessar o sistema</span>
      </div>
      <v-form>
        <input hidden type="text" autocomplete="username" value="">
        <div>
          <div class="text-subtitle-1 required">Nova senha</div>
          <v-text-field
            ref="password"
            :rules="rules"
            tabindex="2"
            v-model="formData.password"
            @input="validatePassword"
            :append-inner-icon="visiblePassword ? 'mdi-eye' : 'mdi-eye-off'"
            :type="visiblePassword ? 'text' : 'password'"
            density="compact"
            placeholder="Digite sua senha"
            prepend-inner-icon="mdi-lock-outline"
            variant="outlined"
            @click:append-inner="visiblePassword = !visiblePassword"
            autocomplete="new-password"
          ></v-text-field>
        </div>
        <div class="password-requisites mb-3">
          <div
            class="d-flex justify-content-center align-center"
            v-for="validation in passwordRequisites" :key="validation.name"
          >
            <v-icon class="mx-2" size="small">{{ validation.isValid ? 'mdi-check' : 'mdi-close' }}</v-icon>
            <span :class="(validation.isValid ? 'approved' : 'reject')">
              {{ validation.description }}
            </span>
          </div>
        </div>
        <div>
          <div class="text-subtitle-1 required">Confirme a senha</div>
          <v-text-field
            ref="confirmPassword"
            :rules="rules"
            tabindex="2"
            v-model="formData.confirmPassword"
            :append-inner-icon="visibleConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :type="visibleConfirmPassword ? 'text' : 'password'"
            density="compact"
            placeholder="Digite novamente sua senha"
            prepend-inner-icon="mdi-lock-outline"
            variant="outlined"
            @click:append-inner="visibleConfirmPassword = !visibleConfirmPassword"
            autocomplete="new-password"
          ></v-text-field>
        </div>
        <div class="d-flex justify-center mt-5">
          <v-btn
            color="primary"
            class="w-100"
            @click="submit"
          >
            Enviar
          </v-btn>
        </div>
      </v-form>
    </template>
  </LoginCard>
</template>

<script lang="js">

import LoginCard from '@/components/LoginCard';
import Login from '@/controllers/Login';
import Alert from '@/util/Alert';
import Rule from '@/util/Rule';
import StorageHandler from '@/util/StorageHandler';
import { ref } from 'vue';

export default {
  components: {
    LoginCard,
  },
  methods: {
    validatePassword() {
      const { password } = this.formData;
      this.passwordRequisites.forEach(validation => {
        validation.isValid = validation.test(password);
      })
    },
    async submit() {
      const newPassResult = await this.$refs.password.validate();
      const confirmNewPassResult = await this.$refs.confirmPassword.validate();
      const isFilledPass = newPassResult.length === 0 && confirmNewPassResult.length === 0;
      if (isFilledPass) {
        if (this.formData.password !== this.formData.confirmPassword) {
          return Alert.showError("As senhas digitadas nos campos 'Senha' e 'Confirmar senha' não correspondem.");
        }
        const isValidPass = this.passwordRequisites.every(({ isValid }) => isValid);
        if (isValidPass) {
          this.loading = true;
          Login.redefinePassword(this.formData.password).then((redefined) => {
            if (redefined) {
              Alert.showSuccess('Senha redefinida. Redirecionando para tela de login.');
              setTimeout(() => {
                this.$router.push({ path: '/login' });
              }, 3000);
            }
          }).finally(() => this.loading = false);
        } else {
          Alert.showWarn('A senha deve atender aos requisitos');
        }
      }
    }
  },
  setup() {
    const formData = ref({ password: null, confirmPassword: null });
    const isRedefinePass = !!StorageHandler.getForgotPassUser();
    const title = ref(isRedefinePass ? 'Redefinição de senha' : 'Criar senha');
    const visiblePassword = ref(false);
    const loading = ref(false);
    const visibleConfirmPassword = ref(false);
    const passwordRequisites = ref([
      {
        name: 'PASSWORD_MIN_SIZE',
        description: 'Mín. 8 caracteres',
        isValid: false,
        test: (value) => value.length >= 8,
      },
      {
        name: 'PASSWORD_MAX_SIZE',
        description: 'Máx. 32 caracteres',
        isValid: false,
        test: (value) => value.length && value.length <= 32,
      },
      {
        name: 'REQUIRED_NUMBER',
        description: 'Possui 1 número',
        isValid: false,
        test: (value) => /[0-9]/gi.test(value),
      },
      {
        name: 'REQUIRED_LETTER',
        description: 'Possui 1 letra',
        isValid: false,
        test: (value) => /[A-z]/gi.test(value),
      },
      {
        name: 'REQUIRED_SPECIAL_CHR',
        description: 'Possui 1 caractere especial',
        isValid: false,
        test: (value) => /[^A-z0-9]/gi.test(value)
      },
    ]);
    return {
      title,
      formData,
      loading,
      passwordRequisites,
      visiblePassword,
      visibleConfirmPassword,
      rules: [Rule.required()],
    }
  }
}

</script>

<style lang="scss">
.approved {
  color: green;
}
.rejected {
  color: red;
}
.description, .password-requisites {
  font-size: 0.9rem;
  color: #999999;
}
.password-requisites span {
  text-align: center;
}
</style>
