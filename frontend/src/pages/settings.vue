<template>
  <Panel :panel="panelConfig">
    <template #content>
      <v-row>
        <v-col cols='12' md='3' lg='3'>
          <div class="text-subtitle-1 required">Aviso de Planejamento</div>
          <v-text-field
            v-model="formData.daysBeforePlanningAlert"
            hide-spin-buttons
            type="number"
            density="compact"
            placeholder="Nº de dias"
            suffix="dia(s)"
            variant="outlined"
            hint="Nº de dias anterior ao planejamento para avisar o professor da pendência de envio"
          />
        </v-col>
        <v-col cols='12' md='4' lg='4'>
          <div class="text-subtitle-1 required">Prazo mínimo de envio de planejamento</div>
          <v-text-field
            v-model="formData.daysLimitSendPlanning"
            hide-spin-buttons
            type="number"
            density="compact"
            placeholder="Nº de dias"
            suffix="dia(s) antes"
            variant="outlined"
            hint="Nº de dias anteriores ao planejamento que o sistema deve permitir o envio"
          />
        </v-col>
        <v-col cols='12' md='4' lg='4'>
          <div class="text-subtitle-1 required">Prazo mínimo de envio de solicitação de material</div>
          <v-text-field
            v-model="formData.daysLimitSendMaterialRequest"
            hide-spin-buttons
            type="number"
            density="compact"
            placeholder="Nº de dias"
            suffix="dia(s) antes"
            variant="outlined"
            hint="Nº de dias anteriores a solicitação do material que o sistema deve permitir o envio"
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
      daysLimitSendPlanning: 1,
      daysLimitSendMaterialRequest: 15,
    });
    return {
      panelConfig,
      formData,
    }
  }
}

</script>
<style lang="scss"></style>
