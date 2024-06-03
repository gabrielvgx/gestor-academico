<template>
  <div class="text-subtitle-1">{{ label }}</div>
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
          @click:clear="clearSelectedDates"
          :rules="rules"
          v-bind="props"
        />
      </template>
      <v-date-picker
        v-model="selectedDates"
        color="primary"
        hide-header
        multiple
        show-adjacent-months

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
  nextMonday,
  isThisWeek,
  isWeekend,
  isAfter,
  isBefore,
} from 'date-fns'
import Rule from '@/util/Rule';

export default {
  props: ['options', 'disabled'],
  emits: ['change'],
  computed: {
    formattedDate() {
      if (this.selectedDates.length === 0) {
        return '';
      }
      const [ startDate ] = this.selectedDates;
      const endDate = this.selectedDates[this.selectedDates.length - 1];
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
    getMinDate() {
      return format(nextMonday(new Date()), 'yyyy-MM-dd');
    },
    clearSelectedDates() {
      this.selectedDates = [];
      this.$emit('change', { dates: []});
    },
    allowedDates(value) {
      return !isWeekend(value);
    },
    onChangeDate(value) {
      if (this.selectedDates.length === 2) {
        let [start, end] = this.selectedDates;
        if (isAfter(start, end)) {
          let aux = start;
          start = end;
          end = aux;
        }
        let curDate = start;
        this.selectedDates = [start];
        do {
          curDate = add(curDate, { days: 1 });
          if (this.allowedDates(curDate) && isBefore(curDate, end)) {
            this.selectedDates.push(curDate);
            console.log(curDate);
          }
        } while (isBefore(curDate, end));
        this.selectedDates.push(end);
      } else if (this.selectedDates.length > 2) {
        const curValue = value.pop();
        this.selectedDates = [curValue];
      }
      this.$emit('change', { selectedDates: this.selectedDates });
    }
  },
  setup(props) {
    const label = ref(props.options.label);
    const isMenuOpen = ref(false);
    const selectedDates = ref(props.options.value || []);
    const rules = [Rule.required()];
    const disabled = props.disabled || false;

    return {
      label,
      isMenuOpen,
      selectedDates,
      isThisWeek,
      rules,
      disabledField: disabled,
    };
  }
}
</script>
<style lang="scss"></style>
