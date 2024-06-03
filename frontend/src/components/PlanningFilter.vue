<template>
  <v-form ref="form">
    <v-row class="">
      <v-col class="py-0" cols="12">
        <v-select
          class="required"
          v-model="formData.school"

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
      <!-- <v-col class="py-0" cols="12" lg="6" md="6" sm="12">
        <v-select
          class="required"
          v-model="formData.classId"
          :rules="rules"
          label="Turma"
          :items="allClass"
          item-title="NMTURMA"
          item-value="ID"
          density="comfortable"
          variant="underlined"
          :loading="loadingClass"
          :disabled="loadingClass || !formData.school"
        />
      </v-col> -->
      <v-col class="py-0" cols="12">
        <DatePickerMonth :options="{label: dateLabel || 'Mês do Planejamento'}" @change="onChangeMonth" />
      </v-col>
    </v-row>
  </v-form>
</template>
<script lang="js">
import { ref } from 'vue';
import DatePickerMonth from '@/components/DatePickerMonth';
import School from '@/controllers/School';
// import ClassController from '@/controllers/ClassController';
import Rule from '@/util/Rule';

export default {
  props: ['config'],
  components: {
    DatePickerMonth,
  },
  methods: {
    onChangeMonth({ month, year }) {
      this.formData.month = month;
      this.formData.year = year;
    },
    async isValid() {
      const { valid } = await this.$refs.form.validate();
      return valid;
    },
    getValue() {
      return { ... this.formData };
    }
  },
  setup(props) {
    const formData = ref({
      school: null,
      // classId: null,
      month: new Date().getMonth(),
      year: new Date().getFullYear(),
    });
    const schools = ref([]);
    // const allClass = ref([]);
    const loadingSchool = ref(true);
    // const loadingClass = ref(false);
    // const changeSchool = () => {
    //   loadingClass.value = true;
    //   ClassController.list(formData.value.school).then(result => {
    //     allClass.value = result;
    //     if (result.length === 1) {
    //       formData.value.classId = result[0].ID;
    //     }
    //   }).finally(() => loadingClass.value = false);
    // }
    School.list().then((data) => {
      schools.value = data;
      if (data.length === 1) {
        formData.value.school = data[0].ID;
        // changeSchool();
      }
    }).finally(() => loadingSchool.value = false);
    const rules = [Rule.required()];
    return {
      formData,
      schools,
      loadingSchool,
      // loadingClass,
      // allClass,
      rules,
      dateLabel: props.config.dateLabel,
      // changeSchool,
    }
  }
}
</script>
<style lang="scss"></style>
