<template>
  <v-container class='user-container generic-container'>
    <v-form class="user-form generic-form" ref="form">
      <v-row class="form-title">
        <h3>Cadastro de Usuário</h3>
      </v-row>
      <div>
        <div class="text-subtitle-1 required">Nome</div>
        <v-text-field
            v-model="formData.name"
            :rules="rules"
            type="text"
            density="compact"
            placeholder="Nome"
            variant="outlined"
            autocomplete="name"
        ></v-text-field>
      </div>
      <div>
        <div class="text-subtitle-1 required">E-mail</div>
        <v-text-field
          v-model="formData.email"
          :rules="rules"
          type="text"
          density="compact"
          placeholder="E-mail"
          variant="outlined"
          autocomplete="email"
        ></v-text-field>
      </div>
      <div>
        <v-select
          class="required"
          :rules="rules"
          label="Cargo"
          :items="['Professor(a)', 'Coordenador(a) / Diretor(a)', 'Profissional da Cozinha']"
          density="comfortable"
          variant="underlined"
        ></v-select>
      </div>
      <div>
        <v-select
          class="required"
          :rules="rules"
          label="Escola"
          :items="['EMEI Alto Vera Cruz', 'EMEI Teste1', 'EMEI Teste2',]"
          density="comfortable"
          variant="underlined"
        ></v-select>
      </div>
      <div>
        <v-select
          class="required"
          :rules="rules"
          label="Turma"
          :items="['Turma dos Amigos 5/6 Anos', 'Turma Beija Flor 3/4 Anos',]"
          density="comfortable"
          variant="underlined"
        ></v-select>
      </div>
      <section class="inputs d-flex flex-column">
        <v-row>

        </v-row>
        <v-row>

        </v-row>
      </section>
      <v-btn color="primary">Confirmar</v-btn>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';

export default {
  name: 'user-form',
  components: {},
  methods: {
    async login() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        Login.auth(this.formData);
      }
    },
  },
  setup() {
    const visible = ref(false);
    const formData = ref({
      name: null,
      email: null,
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
</style>
