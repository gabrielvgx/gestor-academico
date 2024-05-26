<template>
  <v-container class='generic-container flex-column'>
    <div class="graph-list w-100 h-100">
      <CardList :data="cards" @onClick="(card) => $router.push({ path: `/${card.name}`})" />
      <Pie
        v-if="loadedPlanning"
        :options="planningOptions"
        @onSelect="onSelectPlanning"
      />
      <Bar :options="{chartName: 'food-graph'}" ></Bar>
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
    DashboardController.getPlanningGraphOptions().then(planning => {
      planningOptions.value = planning;
      loadedPlanning.value = true;
    });
    return {
      loadedPlanning,
      planningOptions,
      rules: [
        Rule.required(),
      ],
      cards: [
        {
          name: 'material-request',
          title: 'Req. de Materiais Pendentes',
          content: '1',
          icon: 'mdi-clipboard-clock-outline',
          color: 'green',
        },
        {
          name: 'planning-management',
          title: 'Planejamentos Pendentes',
          content: '12',
          icon: 'mdi-book-clock',
          color: 'warning',
          footer: '',
        }
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
