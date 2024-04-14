<template>
  <v-container class='pa-0 w-100 h-100 d-flex generic-container'>
    <v-form class="school-form d-flex flex-column generic-form" ref="form">
      <v-row class="form-title">
        <h3>Cadastro de Escola / Turma</h3>
      </v-row>
      <div class="form-body">
        <div>
          <div class="text-subtitle-1 required">Nome da Escola</div>
          <v-text-field
              v-model="formData.schoolName"
              :rules="rules"
              type="text"
              density="compact"
              placeholder="Ex.: EMEI Nova Lima"
              variant="outlined"
          ></v-text-field>
        </div>
        <div v-for="(_, idx) in formData.classCollection" v-bind:key="`class_${idx}`">
          <div class="text-subtitle-1 required">Nome da Turma {{ formData.classCollection.length > 1 ? idx + 1 : ''  }}</div>
          <div class="d-flex">
            <v-text-field
                v-model="formData.classCollection[idx]"
                :rules="rules"
                type="text"
                density="compact"
                placeholder="Ex.: Novo Amanhecer"
                variant="outlined"
            ></v-text-field>
            <v-btn class="ms-3" color="success" icon="mdi-plus" density="comfortable" @click="() => formData.classCollection.push(null)"></v-btn>
            <v-btn v-if="idx > 0" class="ms-2" color="error" icon="mdi-delete-outline" density="comfortable" @click="() => formData.classCollection.splice(idx, 1)"></v-btn>
          </div>
        </div>
      </div>
      <v-btn color="primary" @click="() => console.log(formData.classCollection)">Confirmar</v-btn>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';

export default {
  name: 'school-form',
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
      schoolName: null,
      classCollection: [null],
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
