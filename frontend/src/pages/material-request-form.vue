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
        <div class="text-subtitle-1 required">Previsão de Utilização</div>
        <v-locale-provider locale="BR">
          <v-date-picker
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
    </v-container>
  </v-form>
  <Modal :modal="modal" v-if="openedModal" @close="closeModal" @confirm="confirmMaterial">
    <template #content>
      <MaterialList @changeItemQuantity="changeItemQuantity"/>
    </template>
  </Modal>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';
import { format, add } from 'date-fns';
import Modal from '@/components/Modal';
import MaterialList from '@/components/MaterialList';
import Token from '@/util/Token';

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
    },
    changeItemQuantity({ item, quantity }) {
      if (quantity === 0) {
        delete this.formData.material[item.ID];
      } else {
        this.formData.material[item.ID] = {
          ...item,
          QUANTITY: quantity
        };
        console.log(this.formData.material);
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
  setup(props) {
    const visible = ref(false);
    const openedModal = ref(false);
    const defaultValue = {
      username: Token.getUserName(),
      reason: null,
      utilizationDate: null,
      material: {},
    };
    const formData = ref({ ...defaultValue, ...props.data });
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
