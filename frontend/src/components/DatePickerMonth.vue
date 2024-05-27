<template>
  <div class="text-subtitle-1 required">{{ label }}</div>
  <v-locale-provider locale="BR">
    <v-menu v-model="isMenuOpen" :close-on-content-click="false">
      <template v-slot:activator="{ props }">
        <v-text-field
          :model-value="formattedDate"
          readonly
          density="compact"
          variant="outlined"

          persistent-hint
          clearable

          @click:clear="date = null"
          :rules="rules"
          v-bind="props"
        />
      </template>
      <v-date-picker
        class="month-picker"
        color="primary"
        v-model="date"
        view-mode="months"
        @update:month="changeMonth"
        hide-header
      >
        <template #default>
          <h3>header</h3>
        </template>
        <template #actions>
          <div class="w-100 d-flex justify-space-around">
            <v-btn prepend-icon="mdi-arrow-left" color="primary" variant="flat">Anterior</v-btn>
            <v-btn append-icon="mdi-arrow-right" color="primary" variant="flat">Próximo</v-btn>
          </div>
        </template>
      </v-date-picker>
    </v-menu>
  </v-locale-provider>
</template>
<script lang="js">
import { ref } from 'vue';
import {
  format,
  add,
  previousMonday,
  isMonday,
  isFriday,
  isWeekend,
  isThisWeek,
} from 'date-fns'
import Rule from '@/util/Rule';
import { ptBR } from "date-fns/locale";

export default {
  props: ['options'],
  computed: {
    formattedDate() {
      return this.date ? format(new Date(this.selectedYear, this.selectedMonth, 1), 'MMMM/yyyy', { locale: ptBR }) : '';
    },
  },
  methods: {
    changeMonth(value) {
      this.isMenuOpen = false;
      this.selectedMonth = value;
      this.date = new Date(this.selectedYear, value, 1);
      this.$emit('change', {
        month: value,
        year: this.selectedYear,
        formatted: format(new Date(this.selectedYear, value, 1), 'yyyy-MM-dd')
      });
    },
    getMaxDate() {
      const maxDate = add(new Date(), { months: 3 });
      return format(maxDate, 'yyyy-MM-dd');
    },
    clearSelectedDates() {
      this.planningDate = [];
    },
    getFormattedNow() {
      return format(new Date(), 'yyyy-MM-dd');
    },
    allowedDates(value) {
      return !isWeekend(value);
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
      while (!isFriday(curDate)) {
        curDate = add(curDate, { days: 1 });
        selectedDates.push(curDate);
      }
      this.planningDate = selectedDates;
    },
  },
  setup(props) {
    const label = ref(props.options.label);
    const isMenuOpen = ref(false);
    const planningDate = ref([]);
    const date = ref(new Date());
    const selectedMonth = ref(new Date().getMonth());
    const selectedYear = new Date().getFullYear();
    const rules = [Rule.required()];

    return {
      label,
      selectedMonth,
      selectedYear,
      date,
      isMenuOpen,
      planningDate,
      isThisWeek,
      rules,
    };
  }
}
</script>
<style lang="scss">
.month-picker .v-date-picker-controls {
   .v-date-picker-controls__month {
    display: none;
  }
  cursor: not-allowed;
  pointer-events: none;

  // /*Button disabled - CSS color class*/
  color: #c0c0c0;
  background-color: #ffffff;
}
</style>
