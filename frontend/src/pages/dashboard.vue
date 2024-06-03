<template>
  <v-container class='generic-container flex-column'>
    <v-container>
      <div>
        <div class="text-subtitle-1">Escola</div>
        <v-select
          v-model="formData.schoolId"
          @update:modelValue="() => {refreshPlanningGraph(); refreshFoodGraph();}"
          :items="formData.schools"
          item-title="NMESCOLA"
          :rules="rules"
          item-value="ID"
          density="compact"
          variant="outlined"
          :loading="loadingSchool"
        />
      </div>
      <div>
        <DatePickerRange
          :options="{label: 'Período', value: defaultPeriod}"
          @change="onChangePeriod"
        />
      </div>
    </v-container>
    <div class="graph-list w-100 h-100">
      <CardList :data="cards" @onClick="(card) => $router.push({ path: `/${card.name}`})" />
      <Pie
        v-if="loadedPlanning && isSupervisor"
        :options="planningOptions"
        @onSelect="onSelectPlanning"
      />
      <Bar
        v-if="loadedFood && isSupervisor"
        :options="foodOptions"
      />
    </div>
    <Modal v-if="false" :modal="{}"></Modal>
  </v-container>
</template>
<script lang="js">
import Rule from '@/util/Rule';
import Pie from '@/components/charts/Pie';
import Bar from '@/components/charts/Bar';
import Modal from '@/components/Modal';
import CardList from '@/components/CardList';
import DashboardController from '@/controllers/Dashboard';
import { ref } from 'vue';
import Token from '@/util/Token';
import { useRoute, useRouter } from 'vue-router';
import School from '@/controllers/School';
import DatePickerRange from '@/components/DatePickerRange';
import { add, endOfMonth, isBefore, isWeekend } from 'date-fns';

export default {
  name: 'dashboard',
  components: {
    Pie,
    Bar,
    Modal,
    CardList,
    DatePickerRange,
  },
  methods: {
    onSelectPlanning(params) {
      console.log(params.data);
    },
    onChangePeriod({ selectedDates }) {
      if (selectedDates.length === 1) return;
      const [start] = selectedDates;
      const end = selectedDates[selectedDates.length-1];
      this.formData.period = [start, end];
      this.refreshPlanningGraph();
    }
  },
  setup() {
    const planningOptions = ref({});
    const foodOptions = ref({});
    const loadedPlanning = ref(false);
    const loadedFood = ref(false);
    const loadingSchool = ref(false);
    const formData = ref({
      schoolId: null,
      schools: [],
      period: [],
    });
    const userProfile = Token.getUserProfile();
    const isSupervisor = userProfile === 'SUPERVISOR';
    const defaultPeriod = (() => {
      const nextMonth = new Date().getMonth() + 1;
      const startDate = new Date(new Date().getFullYear(), nextMonth, 1);
      const endDate = endOfMonth(startDate);
      let curDate = startDate;
      const period = [startDate];
      do {
        curDate = add(curDate, { days: 1 });
        if (!isWeekend(curDate) && isBefore(curDate, endDate)) {
          period.push(curDate);
        }
      } while(isBefore(curDate, endDate));
      period.push(endDate);
      formData.value.period = [startDate, endDate];
      return period;
    })();
    const refreshPlanningGraph = () => {
      if (formData.value.period.length === 2 && formData.value.schoolId) {
        loadedPlanning.value = false;
        DashboardController.getPlanningGraphOptions(formData.value.schoolId, formData.value.period).then(planning => {
          planningOptions.value = planning;
          loadedPlanning.value = true;
        });
      }
    }
    const refreshFoodGraph = () => {
      console.log(isSupervisor, formData.value.schoolId);
      if (isSupervisor && formData.value.schoolId) {
        DashboardController.getFoodGraphOptions(formData.value.schoolId).then((data) => {
          console.log(data);
          foodOptions.value = data;
          loadedFood.value = true;
        });
      }
    }
    loadingSchool.value = true;
    School.list().then(data => {
      formData.value.schools = data;
      if (data.length === 1) {
        formData.value.schoolId = data[0].ID;
        refreshPlanningGraph();
      }
    }).finally(() => loadingSchool.value = false);
    const route = useRoute();
    const router = useRouter();
    if (route.path === '/dashboard' && userProfile === 'KITCHEN') {
      router.push({ path: '/food-record'});
    }
    return {
      formData,
      loadingSchool,
      loadedPlanning,
      foodOptions,
      loadedFood,
      planningOptions,
      defaultPeriod,
      refreshPlanningGraph,
      refreshFoodGraph,
      isSupervisor,
      rules: [
        Rule.required(),
      ],
      cards: [
        {
          name: 'material-request',
          title: 'Req. de Materiais Pendentes',
          content: '1',
          icon: 'mdi-clipboard-clock-outline',
          isVisible: Token.getUserProfile() === 'SUPERVISOR',
          color: 'green',
        },
        {
          name: 'planning-management',
          title: 'Planejamentos Pendentes',
          content: '12',
          icon: 'mdi-book-clock-outline',
          isVisible: Token.getUserProfile() === 'SUPERVISOR',
          color: 'warning',
          footer: '',
        },
        {
          name: 'planning-rejected',
          title: 'Planejamentos Rejeitados',
          content: '12',
          icon: 'mdi-book-cancel-outline',
          color: 'error',
          isVisible: Token.getUserProfile() === 'TEACHER',
          footer: '',
        },
        {
          name: 'planning-rejected',
          title: 'Solicitações de Material Rejeitadas',
          content: '12',
          icon: 'mdi-clipboard-remove-outline',
          color: 'error',
          isVisible: Token.getUserProfile() === 'TEACHER',
          footer: '',
        },
      ],
    }
  }
}
</script>
<style lang="scss">
.graph-list {
  overflow-y: auto;
}
</style>
