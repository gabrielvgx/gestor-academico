<template>
  <v-container class='pa-0 w-100 h-100 d-flex' style="margin: auto;">
    <v-form class="school-form d-flex flex-column" ref="form">
      <h4>Selecione a escola/turma que deseja utilizar</h4>
      <section class="inputs d-flex flex-column">
        <v-row>
          <v-select
            label="Escola"
            :items="['EMEI Alto Vera Cruz', 'EMEI Teste1', 'EMEI Teste2',]"
            density="comfortable"
            variant="underlined"
          ></v-select>
        </v-row>
        <v-row>
          <v-select
            label="Turma"
            :items="['Turma dos Amigos 5/6 Anos', 'Turma Beija Flor 3/4 Anos',]"
            density="comfortable"
            variant="underlined"
          ></v-select>
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
  name: 'school-select',
  components: {},
  methods: {
    async login() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        console.log(this.formData, isValid);
        Login.auth(this.formData);
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
.school-form {
  margin: auto;
  max-width: max(50vh, 300px);
  min-width: 30vw;
  gap: 3rem;
}
</style>
