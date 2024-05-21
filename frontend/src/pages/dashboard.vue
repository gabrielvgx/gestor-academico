<template>
  <v-container class='generic-container'>
    <div class="graph-list w-100 h-100">
      <Pie v-if="loadedPlanning" :options="planningOptions" @onSelect="onSelectPlanning"></Pie>
      <Bar :options="{}"></Bar>
    </div>
    <Modal v-if="false" :modal="{}"></Modal>
  </v-container>
</template>
<script lang="js">
import Rule from '@/util/Rule';
import Pie from '@/components/charts/Pie.vue';
import Bar from '@/components/charts/Bar.vue';
import Modal from '@/components/Modal.vue';
import DashboardController from '@/controllers/Dashboard.js';
import { ref } from 'vue';

export default {
  name: 'dashboard',
  components: {
    Pie,
    Bar,
    Modal,
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
    }
  }
}
</script>
<style lang="scss">
.graph-list {
  overflow-y: auto;
}
</style>
