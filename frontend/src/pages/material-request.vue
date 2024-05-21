<template>
  <v-container class='user-container generic-container'>
    <v-form class="user-form generic-form" ref="form">
      <v-row class="form-title">
        <h3>Solicitação de Material</h3>
      </v-row>
      <div class="form-body">
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
          <div class="text-subtitle-1 required">Previsão de Utilização</div>
          <v-locale-provider locale="BR">
            <v-date-picker
              :rules="rules"
              hide-header
              v-model="formData.utilizationDate"
              :allowed-dates="allowedDates"
              :min="getFormattedNow()"
              :max="getMaxDate()"
            ></v-date-picker>
          </v-locale-provider>
        </div>
        <!-- <div>
          <v-autocomplete
            class="required"
            :rules="rules"
            label="Material"
            :items="['Caneta', 'Giz de Cera', 'Cartolina', 'Massinha de Modelar']"
            density="comfortable"
            variant="underlined"
            multiple
            chips
          ></v-autocomplete>
        </div> -->
        <div class="d-flex my-3">
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
                class="ms-3"
                @click="() => delete formData.material[material.ID]"
              >mdi-close-circle</v-icon>
            </template>
            </v-chip>
          </div>
        </div>
        <div>
          <div class="text-subtitle-1 required">Justificativa</div>
          <v-textarea
            v-model="formData.reason"
            placeholder="Descreva o motivo da solicitação"
            no-resize
            counter
            :rules="[Rule.required(), Rule.maxCharacters({ max: 200 })]"
          ></v-textarea>
        </div>
      </div>
      <v-btn color="primary">Confirmar</v-btn>
    </v-form>
    <Modal :modal="modal" v-if="openedModal" @close="closeModal" @confirm="confirmMaterial">
      <template #content>
        <MaterialList @changeItemQuantity="changeItemQuantity"/>
      </template>
    </Modal>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';
import { format, add } from 'date-fns';
import Modal from '@/components/Modal';
import MaterialList from '@/components/MaterialList';

export default {
  name: 'material-request',
  components: {
    Modal,
    MaterialList,
  },
  methods: {
    confirmMaterial() {
      this.openedModal = false;
    },
    changeItemQuantity({ item, quantity }) {
      if (quantity === 0) {
        delete this.formData.material[item.ID];
      } else {
        this.formData.material[item.ID] = {
          ...item,
          QUANTITY: quantity
        };
      }
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
    async login() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        Login.auth(this.formData);
      }
    },
  },
  setup() {
    const visible = ref(false);
    const openedModal = ref(false);
    const formData = ref({
      username: localStorage.getItem('USER'),
      reason: null,
      utilizationDate: null,
      material: {},
    });
    const modal = ref({
      title: 'Material',
    });
    return {
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
