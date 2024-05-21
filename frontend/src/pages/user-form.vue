<template>
  <v-form ref="form">
    <v-row>
      <v-col cols="12" lg="6" md="6" sm="12">
        <div class="text-subtitle-1 required">Nome</div>
        <v-text-field
          v-model="formData.name"
          @input="updateFormData"
          :rules="rules"
          type="text"
          density="compact"
          placeholder="Nome"
          variant="outlined"
          autocomplete="name"
        />
      </v-col>
      <v-col>
        <div class="text-subtitle-1 required">E-mail</div>
        <v-text-field
          v-model="formData.email"
          @input="updateFormData"
          :rules="rules"
          type="text"
          density="compact"
          placeholder="E-mail"
          variant="outlined"
          autocomplete="email"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-select
          v-model="formData.office"
          @update:modelValue="updateFormData"
          class="required"
          :rules="rules"
          label="Cargo"
          :items="officeTypes"
          item-title="label"
          item-value="name"
          density="comfortable"
          variant="underlined"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" lg="6" md="6" sm="12">
        <v-select
          class="required"
          v-model="formData.school"
          @update:modelValue="(value) => {changeSchool(value); updateFormData()}"
          :rules="rules"
          label="Escola"
          :items="schools"
          item-title="NMESCOLA"
          item-value="ID"
          density="comfortable"
          variant="underlined"
          :loading="loadingSchool"
          :disabled="loadingSchool"
        />
      </v-col>
      <v-col>
        <v-select
          class="required"
          v-model="formData.classId"
          @update:modelValue="updateFormData"
          :rules="rules"
          label="Turma"
          :items="allClass"
          item-title="NMTURMA"
          item-value="ID"
          density="comfortable"
          variant="underlined"
          :loading="loadingClass"
          :disabled="loadingClass"
        />
      </v-col>
    </v-row>
  </v-form>
</template>
<script lang="js">
import { ref, watch, toRefs } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';
import School from '@/controllers/School';
import ClassController from '@/controllers/ClassController';

export default {
  name: 'user-form',
  components: {},
  props: ['modelValue'],
  methods: {
    async login() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        Login.auth(this.formData);
      }
    },
  },
  setup(props, { emit }) {
    const visible = ref(false);
    const loadingSchool = ref(true);
    const loadingClass = ref(true);
    const schools = ref([]);
    const allClass = ref([]);
    const { modelValue } = toRefs(props);
    const formData = ref({
      name: null,
      email: null,
      office: null,
      school: null,
      classId: null,
      ...modelValue.value,
    });
    // watch(
    //   () => modelValue,
    //   (newValue) => {
    //     formData.value = { ...newValue };
    //   }
    // );
    const changeSchool = () => {
      ClassController.list(formData.value.school).then(result => {
        allClass.value = result;
        if (result.length === 1) {
          formData.value.classId = result[0].ID;
        }
        loadingClass.value = false;
      });
    }
    School.list().then(data => {
      schools.value = data;
      if (data.length === 1) {
        formData.value.school = data[0].ID;
        changeSchool();
      }
      loadingSchool.value = false;
    });
    const officeTypes = [
      {
        name: 'TEACHER',
        label: 'Professor(a)'
      },
      {
        name: 'SUPERVISOR',
        label: 'Diretor(a) / Coordenador(a)'
      },
      {
        name: 'KITCHEN',
        label: 'Profissional da Cozinha'
      }
    ];

    const updateFormData = () => {
      emit('update:modelValue', { ... formData.value });
    };

    watch(modelValue, (newValue) => {
      formData.value = { ...newValue };
    });

    return {
      visible,
      schools,
      allClass,
      loadingClass,
      updateFormData,
      changeSchool,
      officeTypes,
      rules: [
        Rule.required(),
      ],
      formData,
      loadingSchool,
    }
  }
}
</script>
<style lang="scss">
</style>
