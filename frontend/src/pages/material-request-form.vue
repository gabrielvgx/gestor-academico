<template>
  <v-form ref="form" style="margin-bottom: 100px;">
    <!-- <v-row class="form-title">
      <h3>Solicitação de Material</h3>
    </v-row> -->
    <v-container class="pa-0 ma-0 d-flex flex-column">
      <div>
        <div class="text-subtitle-1">Solicitante</div>
        <v-text-field
            v-model="formData.username"
            type="text"
            density="compact"
            placeholder="Nome"
            variant="outlined"
            autocomplete="name"
            disabled
        ></v-text-field>
      </div>
      <div>
        <div class="text-subtitle-1">Data da Solicitação</div>
        <v-text-field
            v-model="formData.solicitationDate"
            type="text"
            disabled
            density="compact"
            variant="outlined"
        ></v-text-field>
      </div>
      <div>
        <div class="text-subtitle-1" :class="isNew && 'required'">Escola</div>
        <v-select
          :disabled="!isNew"
          v-model="this.formData.schoolId"
          :items="this.formData.schools"
          item-title="NMESCOLA"
          :rules="rules"
          item-value="ID"
          density="compact"
          variant="outlined"
          :loading="loadingSchool"
        />
      </div>
      <div>
        <div class="text-subtitle-1 required">Previsão de Utilização</div>
        <v-locale-provider locale="BR">
          <v-date-picker
            :disabled="formData.status === 'APROVADO' || isSupervisor()"
            class="mx-auto"
            :rules="rules"
            hide-header
            v-model="formData.utilizationDate"
            :allowed-dates="allowedDates"
            :min="getFormattedNow()"
            :max="getMaxDate()"
          ></v-date-picker>
        </v-locale-provider>
      </div>
      <div class="d-flex my-3" v-if="formData.status !== 'APROVADO' && !isSupervisor()">
        <v-btn
          color="primary"
          prepend-icon="mdi-plus"
          @click="addMaterial"
        >Incluir Material</v-btn>
      </div>
      <div>
        <div class="text-subtitle-1" v-if="Object.keys(formData.material).length">Materiais selecionados</div>
        <div class="d-flex" style="gap: 0.25rem;">
          <v-chip
            v-for="material in formData.material"
            :key="'material-' + material.ID"
            clear
          >
          <template v-slot:prepend>
            <v-avatar>
              {{ material.QUANTITY }}
            </v-avatar>
          </template>
            <span>{{ material.NMMATERIAL }}</span>
          <template v-slot:append>
            <v-icon
              v-if="formData.status !== 'APROVADO' && !isSupervisor()"
              class="ms-3"
              @click="() => delete formData.material[material.ID]"
            >mdi-close-circle</v-icon>
          </template>
          </v-chip>
        </div>
      </div>
      <div>
        <div class="text-subtitle-1" :class="formData.status !== 'APROVADO' && !isSupervisor() ? 'required' : ''">Justificativa</div>
        <v-textarea
          :disabled="formData.status === 'APROVADO' || isSupervisor()"
          v-model="formData.reason"
          placeholder="Descreva o motivo da solicitação"
          no-resize
          counter
          :rules="[Rule.required(), Rule.maxCharacters({ max: 200 })]"
        ></v-textarea>
      </div>
      <div v-if="isSupervisor() || formData.status === 'REPROVADO'">
        <div class="text-subtitle-1" :class="isSupervisor() ? 'required' : ''">Resposta da solicitação</div>
        <v-textarea
          :disabled="!isSupervisor()"
          v-model="formData.feedback"
          placeholder="Descreva uma resposta para a solicitação"
          no-resize
          counter
          :rules="[Rule.required(), Rule.maxCharacters({ max: 500 })]"
        ></v-textarea>
      </div>
      <v-container v-if="isSupervisor()" class="pt-0 my-0 d-flex justify-center" style="gap: 1rem">
        <v-btn color="error" variant="outlined" prepend-icon="mdi-close" @click="() => $emit('rejected')">Reprovar</v-btn>
        <v-btn color="success" prepend-icon="mdi-check" @click="() => $emit('approve')">Aprovar</v-btn>
      </v-container>
    </v-container>
  </v-form>
  <Modal :modal="modal" v-if="openedModal" @close="closeModal" @confirm="confirmMaterial">
    <template #content>
      <MaterialList ref="materialListRef"/>
    </template>
  </Modal>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import { format, add } from 'date-fns';
import Modal from '@/components/Modal';
import MaterialList from '@/components/MaterialList';
import Token from '@/util/Token';
import School from '@/controllers/School';
import DateHandler from '@/util/DateHandler';

export default {
  name: 'material-request',
  components: {
    Modal,
    MaterialList,
  },
  props: ['data'],
  methods: {
    confirmMaterial() {
      this.openedModal = false;
      const items = this.$refs.materialListRef.getItems();
      this.formData.material = {};
      items.forEach(item => {
        this.formData.material[item.ID] = {...item};
      })
    },
    addMaterial() {
      this.openedModal = true;
    },
    closeModal() {
      this.openedModal = false;
    },
    getMaxDate() {
      const maxDate = add(new Date(), { months: 3 });
      return format(maxDate, 'yyyy-MM-dd');
    },
    getFormattedNow() {
      return format(new Date(), 'yyyy-MM-dd');
    },
    allowedDates(value) {
      const dayOfWeek = format(value, 'i').toString();
      return !['6', '7'].includes(dayOfWeek);
    },
    isSupervisor() {
      return Token.getUserProfile() === 'SUPERVISOR';
    },
    getValue() {
      return {...this.formData};
    },
    async isValid() {
      const { valid } = await this.$refs.form.validate();
      return valid;
    }
  },
  setup(props) {
    const visible = ref(false);
    const openedModal = ref(false);
    const defaultValue = {
      username: Token.getUserName(),
      reason: null,
      utilizationDate: null,
      feedback: null,
      material: {},
      schools: [],
      schoolId: null,
      status: 'PENDENTE',
      solicitationDate: DateHandler.formatDate(new Date(), { to: 'dd/MM/yyyy' }),
    };
    const isNew = !(props.data && props.data.schoolId);

    const loadingSchool = ref(false);
    loadingSchool.value = true;
    School.list().then(data => {
      formData.value.schools = data;
      if (isNew && data.length === 1) {
        formData.value.schoolId = data[0].ID;
      }
    }).finally(() => loadingSchool.value = false);
    const formData = ref({ ...defaultValue, ...props.data });
    const modal = ref({
      title: 'Material',
    });
    return {
      isNew,
      loadingSchool,
      visible,
      rules: [
        Rule.required(),
      ],
      Rule,
      formData,
      modal,
      openedModal,
    }
  }
}
</script>
<style lang="scss">
</style>
