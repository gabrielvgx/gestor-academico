<template>
  <div class="text-subtitle-1 required">{{ label }}</div>
  <v-locale-provider locale="BR">
    <v-menu v-model="isMenuOpen" close-on-content-click>
      <template v-slot:activator="{ props }">
        <v-text-field
          :model-value="formattedDate"
          readonly
          density="compact"
          variant="outlined"
          :hint="planningDate.length && isThisWeek(planningDate[0]) ? 'Semana Atual' : ''"
          persistent-hint
          clearable
          @click:clear="clearSelectedDates"
          :rules="rules"
          v-bind="props"
        />
      </template>
      <v-date-picker
        v-model="planningDate"
        color="primary"
        hide-header
        multiple
        show-adjacent-months
        :min="getFormattedNow()"
        :max="getMaxDate()"
        :allowed-dates="allowedDates"
        @update:modelValue="onChangeDate"
      >
        <!-- <template v-slot:header></template> -->
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

export default {
  props: ['options'],
  computed: {
    formattedDate() {
      if (this.planningDate.length === 0) {
        return '';
      }
      const [ startDate ] = this.planningDate;
      const endDate = this.planningDate[this.planningDate.length - 1];
      const formattedStart = format(startDate, 'dd/MM/yyyy');
      const formattedEnd = format(endDate, 'dd/MM/yyyy');
      return `${formattedStart} - ${formattedEnd}`;
    },
  },
  methods: {
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
    const rules = [Rule.required()];

    return {
      label,
      isMenuOpen,
      planningDate,
      isThisWeek,
      rules,
    };
  }
}
</script>
<style lang="scss"></style>
