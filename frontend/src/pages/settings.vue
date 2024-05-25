<template>
  <Panel :panel="panelConfig">
    <template #content>
      <v-row>
        <v-col>
          <div class="text-subtitle-1 required">Antecedência de Aviso de Planejamento (dias)</div>
          <v-text-field
            v-model="formData.daysBeforePlanningAlert"
            hide-spin-buttons
            type="number"
            density="compact"
            placeholder="Nº de dias"
            dirty
            variant="outlined"
          />
        </v-col>
      </v-row>
    </template>
  </Panel>
</template>
<script lang="js">
import Panel from '@/components/Panel';
import { ref } from 'vue';

export default {
  components: {
    Panel,
  },
  setup() {
    const panelConfig = { title: 'Parametrização do Sistema' };
    const formData = ref({
      daysBeforePlanningAlert: 30,
    });
    return {
      panelConfig,
      formData,
    }
  }
}

</script>
<style lang="scss"></style>
