<template>
  <v-container class='user-container generic-container'>
    <v-form class="user-form generic-form" ref="form">
      <v-row class="form-title">
        <h3>Solicitação de Material</h3>
      </v-row>
      <div class="form-body">
        <div>
          <div class="text-subtitle-1">Solicitante</div>
          <v-text-field
              v-model="formData.username"
              type="text"
              density="compact"
              placeholder="Nome"
              variant="outlined"
              autocomplete="name"
              disabled
          ></v-text-field>
        </div>
        <div>
          <div class="text-subtitle-1 required">Previsão de Utilização</div>
          <v-locale-provider locale="BR">
            <v-date-picker
              :rules="rules"
              hide-header
              v-model="formData.utilizationDate"
              :allowed-dates="allowedDates"
              :min="getFormattedNow()"
              :max="getMaxDate()"
            ></v-date-picker>
          </v-locale-provider>
        </div>
        <div>
          <v-autocomplete
            class="required"
            :rules="rules"
            label="Material"
            :items="['Caneta', 'Giz de Cera', 'Cartolina', 'Massinha de Modelar']"
            density="comfortable"
            variant="underlined"
            multiple
            chips
          ></v-autocomplete>
        </div>
        <div>
          <div class="text-subtitle-1 required">Justificativa</div>
          <v-textarea
            v-model="formData.reason"
            placeholder="Descreva o motivo da solicitação"
            no-resize
            counter
            :rules="[Rule.required(), Rule.maxCharacters({ max: 200 })]"
          ></v-textarea>
        </div>
      </div>
      <v-btn color="primary">Confirmar</v-btn>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';
import { format, add } from 'date-fns';

export default {
  name: 'material-request',
  components: {},
  methods: {
    getMaxDate() {
      const maxDate = add(new Date(), { months: 3 });
      return format(maxDate, 'yyyy-MM-dd');
    },
    getFormattedNow() {
      return format(new Date(), 'yyyy-MM-dd');
    },
    allowedDates(value) {
      const dayOfWeek = format(value, 'i').toString();
      return !['6', '7'].includes(dayOfWeek);
    },
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
      username: localStorage.getItem('USER'),
      reason: null,
      utilizationDate: null,
      material: null,
    });
    return {
      visible,
      rules: [
        Rule.required(),
      ],
      Rule,
      formData,
    }
  }
}
</script>
<style lang="scss">
</style>
