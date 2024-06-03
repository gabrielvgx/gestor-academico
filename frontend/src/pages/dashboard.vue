<template>
  <v-container class='generic-container flex-column'>
    <div class="graph-list w-100 h-100">
      <CardList :data="cards" @onClick="(card) => $router.push({ path: `/${card.name}`})" />
      <Pie
        v-if="loadedPlanning && isSupervisor"
        :options="planningOptions"
        @onSelect="onSelectPlanning"
      />
      <Bar v-if="isSupervisor" :options="{chartName: 'food-graph'}" ></Bar>
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

export default {
  name: 'dashboard',
  components: {
    Pie,
    Bar,
    Modal,
    CardList,
  },
  methods: {
    onSelectPlanning(params) {
      console.log(params.data);
    }
  },
  setup() {
    const planningOptions = ref({});
    const loadedPlanning = ref(false);
    const isSupervisor = Token.getUserProfile() === 'SUPERVISOR';
    DashboardController.getPlanningGraphOptions().then(planning => {
      planningOptions.value = planning;
      loadedPlanning.value = true;
    });
    return {
      loadedPlanning,
      planningOptions,
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
