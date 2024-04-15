<template>
  <v-container class='user-container generic-container'>
    <v-form class="user-form generic-form" ref="form">
      <v-row class="form-title">
        <h3>Planejamento Semanal</h3>
      </v-row>
      <div class="form-body">
        <div>
          <div class="text-subtitle-1">Solicitante</div>
          <v-text-field
              v-model="formData.username"
              type="text"
              density="compact"
              variant="outlined"
              placeholder="Nome"
              autocomplete="name"
              disabled
          ></v-text-field>
        </div>
        <div>
          <div class="text-subtitle-1 required">Semana do planejamento</div>
          <v-locale-provider locale="BR">
            <v-menu v-model="isMenuOpen" :close-on-content-click="false">
              <template v-slot:activator="{ props }">
                <v-text-field
                  :model-value="formattedDate"
                  readonly
                  density="compact"
                  variant="outlined"
                  clearable
                  @click:clear="clearSelectedDates"
                  :rules="rules"
                  v-bind="props"
                ></v-text-field>
              </template>
              <!-- <v-locale-provider locale="de"> -->
              <!-- !!! hide-actions prop too !!! -->
              <v-date-picker
                v-model="formData.planningDate"
                color="primary"
                hide-header
                multiple
                show-adjacent-months
                :min="getFormattedNow()"
                :max="getMaxDate()"
                :allowed-dates="allowedDates"
                @update:modelValue="onChangeDate"
              >
                <template v-slot:header></template>
              </v-date-picker>
              <!-- </v-locale-provider> -->
            </v-menu>
            <!-- <v-date-picker
              multiple
              show-adjacent-months
              :rules="rules"
              hide-header
              v-model="formData.planningDate"
              :allowed-dates="allowedDates"
              :min="getFormattedNow()"
              :max="getMaxDate()"
              @update:modelValue="onChangeDate"
            ></v-date-picker> -->
          </v-locale-provider>
        </div>
        <div>
          <div class="text-subtitle-1 required">Turma</div>
          <v-select
            :items="['Turma dos Amigos 5/6 Anos', 'Turma Beija Flor 3/4 Anos',]"
            density="compact"
            variant="outlined"
          ></v-select>
        </div>
      </div>
      <v-sheet
        max-width="100%"
      >
        <v-slide-group show-arrows mandatory center-active v-if="this.formData.planningDate.length">
          <v-slide-group-item
            v-for="(curDate, idx) in this.formData.planningDate"
            :key="idx"
            v-slot="{ isSelected, toggle }"
          >
            <v-btn
              :color="isSelected ? 'primary' : undefined"
              size="large"
              @click="toggle"
            >
              <div class="d-flex flex-column">
                <span>{{ prettyDate(curDate, 'simple') }}</span>
                <span class="mt-1" style="font-size: small; font-weight: normal">{{ prettyDate(curDate, 'week') }}</span>
              </div>
            </v-btn>
          </v-slide-group-item>
        </v-slide-group>
        <v-row class="d-flex justify-center flex-column mt-5">
          <h3>Manhã 08:30 - 11:00</h3>
          <v-container class="d-flex flex-column w-100 task-list">
            <v-card color="primary" v-for="(task, taskIdx) in taskList" :key="taskIdx">
              {{ task }}
            </v-card>
            <!-- <v-card>Acolhida com legos</v-card>
            <v-card>Organização dos materiais</v-card>
            <v-card>Rotina linear coletiva no quadro</v-card> -->
          </v-container>
        </v-row>
        <v-row class="d-flex justify-center">
          <h3>Tarde 13:00 - 16:00</h3>
        </v-row>
      </v-sheet>
      <v-btn @click="submit" color="primary">Confirmar</v-btn>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import { ptBR } from "date-fns/locale";
import {
  format,
  add,
  previousMonday,
  isMonday,
  isFriday,
  isWeekend,
  isThisWeek,
} from 'date-fns';

export default {
  name: 'week-planning',
  components: {},
  computed: {
    formattedDate() {
      if (this.formData.planningDate.length === 0) {
        return '';
      }
      const [ startDate ] = this.formData.planningDate;
      const endDate = this.formData.planningDate[this.formData.planningDate.length - 1];
      const formattedStart = format(startDate, 'dd/MM/yyyy');
      const formattedEnd = format(endDate, 'dd/MM/yyyy');
      const suffix = isThisWeek(startDate) ? ' (Semana Atual)' : '';
      return `${formattedStart} - ${formattedEnd}${suffix}`;
    },
  },
  methods: {
    prettyDate(curDate, type) {
      if (type === 'simple') {
        return format(curDate, 'EEEE', { locale: ptBR });
      } else if (type === 'week') {
        return format(curDate, 'dd/MM/yy');
      }
      // return format(curDate, 'EEEE (dd/MM/yyy)', { locale: ptBR });
    },
    clearSelectedDates() {
      this.formData.planningDate = [];
    },
    onChangeDate(value) {
      const selectedDate = value.pop();
      let startDate;
      const selectedDates = []
      if (isMonday(selectedDate)) {
        startDate = selectedDate;
      } else {
        startDate = previousMonday(selectedDate);
      }
      selectedDates.push(startDate);
      let curDate = startDate;
      let count = 0;
      while (!isFriday(curDate)) {
        curDate = add(curDate, { days: 1 });
        selectedDates.push(curDate);
        count++;
        if (count > 10) {
          console.log('infinity-loop', selectedDate);
          break;
        }
      }
      this.formData.planningDate = selectedDates;
    },
    getMaxDate() {
      const maxDate = add(new Date(), { months: 3 });
      return format(maxDate, 'yyyy-MM-dd');
    },
    getFormattedNow() {
      return format(new Date(), 'yyyy-MM-dd');
    },
    allowedDates(value) {
      // const dayOfWeek = format(value, 'i').toString();
      return !isWeekend(value); //!['6', '7'].includes(dayOfWeek);
    },
    async submit() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        // Login.auth(this.formData);
      }
      // console.log(this.formData.planningDate);
    },
  },
  setup() {
    const visible = ref(false);
    const isMenuOpen = ref(false);
    const formData = ref({
      username: localStorage.getItem('USER'),
      reason: null,
      planningDate: [],
      material: null,
    });
    return {
      visible,
      rules: [
        Rule.required(),
      ],
      Rule,
      formData,
      isMenuOpen,
      taskList: [
        'Acolhida com legos',
        'Organização dos materiais',
        'Rotina linear coletiva no quadro',
      ],
    }
  }
}
</script>
<style lang="scss">
.v-slide-group__content .v-btn__content {
  text-transform: capitalize;
}
.task-list {
  gap: 1rem;
}
</style>
