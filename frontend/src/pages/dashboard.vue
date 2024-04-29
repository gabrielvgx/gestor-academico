<template>
  <v-container class='generic-container'>
    <div class="graph-list w-100 h-100">
      <Pie :options="planningGraphOption"></Pie>
      <Bar :options="{}"></Bar>
    </div>
  </v-container>
</template>
<script lang="js">
import Rule from '@/util/Rule';
import Pie from '@/components/charts/Pie.vue';
import Bar from '@/components/charts/Bar.vue';
import DashboardController from '@/controllers/Dashboard.js';

export default {
  name: 'dashboard',
  components: {
    Pie,
    Bar,
  },
  methods: {
  },
  setup() {
    const planningGraphOption = DashboardController.getPlanningGraphOptions();
    return {
      planningGraphOption,
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
