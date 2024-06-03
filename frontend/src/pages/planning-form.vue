<template>
  <v-form ref="form">
    <div class="form-body">
      <v-row class="pa-0 ma-0">
        <v-col cols="12" lg="6" md="6" sm="6" class="pa-0 ma-0">
          <div class="text-subtitle-1">Solicitante</div>
          <v-text-field
              v-model="formData.username"
              type="text"
              density="compact"
              variant="outlined"
              placeholder="Nome"
              autocomplete="name"
              disabled
          />
        </v-col>
        <v-col class="pa-0 ma-0">
          <DatePicker
            :options="{ label: 'Semana do planejamento', value: this.formData.planningDate }"
            :disabled="!isNew"
            @change="({ dates }) => changeDates(dates)"
          />
        </v-col>
      </v-row>
      <v-row class="pa-0 ma-0">
        <v-col cols="12" lg="6" md="6" sm="6" class="pa-0 ma-0">
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
        </v-col>
        <v-col class="pa-0 ma-0">
          <div class="text-subtitle-1" :class="isNew && 'required'">Turma</div>
          <v-select
            v-model="this.formData.classId"
            :items="this.formData.allClass"
            :rules="rules"
            item-title="NMTURMA"
            item-value="ID"
            density="compact"
            variant="outlined"
            :disabled="!isNew || !this.formData.schoolId"
            :loading="loadingClass"
          />
        </v-col>
      </v-row>
    </div>
    <v-sheet class="d-flex flex-column">
      <v-slide-group
        class="slide-group"
        v-model="selectedDateIdx"
        ref="slideGroup"
        v-if="this.formData.planningDate.length"

        mobile
        mandatory
        center-active
      >
        <v-slide-group-item
          v-for="(curDate, idx) in this.formData.planningDate"
          :key="idx"
          :value="idx"
          v-slot="{ isSelected, toggle }"
        >
          <v-btn
            :color="isSelected ? 'primary' : undefined"
            :class="isSelected ? 'active' : ''"
            size="large"
            @click="toggle"
          >
            <div class="d-flex flex-column">
              <span>{{ prettyDate(curDate, 'simple') }}</span>
              <span class="mt-1" style="font-size: small; font-weight: normal">{{ prettyDate(curDate, 'week') }}</span>
            </div>
          </v-btn>
        </v-slide-group-item>
      </v-slide-group>
      <v-container class="pa-0 mt-0 mx-auto" style="margin-bottom: 100px !important;" v-if="this.formData.planningDate.length">
        <v-row
          class="d-flex justify-center flex-column mt-5 mx-auto align-center"
          v-for="(turno, turnoIdx) in this.formData.data[this.selectedDateIdx]?.TURNO || []"
          :key="`atv_${turnoIdx}`"
        >
          <h3>{{ turno.NMTURNO }}</h3>
          <v-container class="d-flex flex-column w-100 task-list">
            <v-textarea
              label="Atividades"
              persistent-placeholder
              :disabled="this.formData.status === 'APROVADO'" variant="outlined"
              v-model="turno.DSATIVIDADE"
            />
          </v-container>
        </v-row>
        <v-container class="ma-0 pt-0 d-flex flex-column" style="gap: 0.5rem">
          <h4>Objetivos</h4>
          <v-container class="ma-0 pa-0 d-flex flex-wrap" style="gap: 1rem;">
            <v-chip
              v-for="(target, targetIdx) in this.formData.data[this.selectedDateIdx]?.BNCC || []"
              :key="`target_${targetIdx}`"
              >
              {{ target.CODBNCC }}
            </v-chip>
            <v-btn
              v-if="!isNew || this.formData.status !== 'APROVADO'"
              prepend-icon="mdi-pencil"
              color="primary"
              @click="openTargetList"
            >
              Editar
            </v-btn>
          </v-container>
        </v-container>
        <v-container class="ma-0 pt-0 d-flex flex-column" v-if="!isNew">
          <h4>Justificativa do Retorno - {{prettyDate(this.formData.planningDate[this.selectedDateIdx], 'week')}}</h4>
          <v-textarea
            variant="outlined"
            :disabled="!isSupervisor()"
            v-model="this.formData.reason"
          />
        </v-container>
        <v-container v-if="isSupervisor()" class="pt-0 my-0 d-flex justify-center" style="gap: 1rem">
          <v-btn color="error" variant="outlined" prepend-icon="mdi-close">Reprovar</v-btn>
          <v-btn color="success" prepend-icon="mdi-check">Aprovar</v-btn>
        </v-container>
      </v-container>
      <!-- <v-row class="d-flex justify-center">
        <h3>Tarde 13:00 - 16:00</h3>
      </v-row> -->
    </v-sheet>
    <!-- <v-btn @click="submit" color="primary">Confirmar</v-btn> -->
  </v-form>
  <Modal :modal="targetListModal" v-if="openedTargetList" @close="closeTargetList" @confirm="confirmTargetList">
    <template #content>
      <EducationTargetList ref="educationTargetRef" :data="targetListData"/>
    </template>
  </Modal>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import { ptBR } from "date-fns/locale";
import DatePicker from '@/components/DatePicker';

import {
  format,
  isThisWeek,
} from 'date-fns';
import Token from '@/util/Token';
import School from '@/controllers/School';
import ClassController from '@/controllers/ClassController';
import Period from '@/controllers/Period';
import EducationTargetList from '@/components/EducationTargetList';
import EducationTarget from '@/controllers/EducationTarget';
import DateHandler from '@/util/DateHandler';

export default {
  name: 'week-planning',
  components: {
    DatePicker,
    EducationTargetList,
  },
  computed: {
    formattedDate() {
      if (this.formData.planningDate.length === 0) {
        return '';
      }
      const [ startDate ] = this.formData.planningDate;
      const endDate = this.formData.planningDate[this.formData.planningDate.length - 1];
      const formattedStart = format(startDate, 'dd/MM/yyyy');
      const formattedEnd = format(endDate, 'dd/MM/yyyy');
      const suffix = isThisWeek(startDate) ? ' (Semana Atual)' : '';
      return `${formattedStart} - ${formattedEnd}${suffix}`;
    },
  },
  methods: {
    changeDates(dates) {
      this.formData.planningDate = dates;
      this.formData.data = dates.map(date => {
        return {
          DTPLANO: DateHandler.formatDate(date, {to: 'dd/MM/yyyy'}),
          CODBNCC: '',
          DSRETORNO: '',
          BNCC: [],
          TURNO: this.formData.period.map(item => ({
            ...item,
            DSATIVIDADE: '',
          })),
        }
      })
    },
    closeTargetList() {
      this.openedTargetList = false;
    },
    confirmTargetList() {
      this.formData.data[this.selectedDateIdx].BNCC = this.$refs.educationTargetRef.getSelectedItems();
      this.openedTargetList = false;
    },
    async openTargetList() {
      await this.targetListPromise;
      this.openedTargetList = true;
    },
    isSupervisor() {
      return Token.getUserProfile() === 'SUPERVISOR';
    },
    prettyDate(curDate, type) {
      if (type === 'simple') {
        return format(curDate, 'EEEE', { locale: ptBR });
      } else if (type === 'week') {
        return format(curDate, 'dd/MM/yy');
      }
      // return format(curDate, 'EEEE (dd/MM/yyy)', { locale: ptBR });
    },
    clearSelectedDates() {
      this.formData.planningDate = [];
      this.formData.data = [];
    },
    async submit() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        // Login.auth(this.formData);
      }
      // console.log(this.formData.planningDate);
    },
    async isValid() {
      const { valid } = await this.$refs.form.validate();
      return valid;
    },
    getValue() {
      return { ...this.formData }
    }
  },
  props: ['data'],
  setup(props) {
    const visible = ref(false);
    const isMenuOpen = ref(false);
    const selectedDateIdx = ref(0);
    const loadingSchool = ref(false);
    const loadingClass = ref(false);
    const openedTargetList = ref(false);
    const targetListModal = ref({ title: 'Objetivos (BNCC)'});
    const targetListData = ref([]);
    const defaultValue = {
      username: Token.getUserName(),
      reason: null,
      schoolId: null,
      schools: [],
      classId: null,
      allClass: [],
      planningDate: [],
      educationTarget: [],
      data: [],
      status: 'PENDENTE',
      period: [], // data[this.selectedDateIdx].TURNO / NMTURNO / DSATIVIDADE
    }
    const isNew = !props.data.schoolId;
    const formData = ref({ ...defaultValue, ...props.data });

    const loadClass = () => {
      loadingClass.value = true;
      ClassController.list(formData.value.schoolId).then(allClass => {
        formData.value.allClass = allClass;
        if (allClass.length === 1) {
          formData.value.classId = allClass[0].ID;
        }
      }).finally(() => loadingClass.value = false);
    }
    const loadSchool = () => {
      loadingSchool.value = true;
      School.list().then(data => {
        formData.value.schools = data;
        if (data.length === 1) {
          formData.value.schoolId = data[0].ID;
          loadClass();
        }
      }).finally(() => loadingSchool.value = false);
    };
    const targetListPromise = EducationTarget.list().then(data => {
      targetListData.value = data;
    })
    const loadPeriod = async () => {
      formData.value.period = await Period.list();
    }
    if (isNew) {
      loadSchool();
      loadPeriod();
    }

    return {
      visible,
      targetListData,
      selectedDateIdx,
      openedTargetList,
      targetListModal,
      targetListPromise,
      rules: [
        Rule.required(),
      ],
      isNew,
      Rule,
      formData,
      isMenuOpen,
      loadingSchool,
      loadingClass,
    }
  }
}
</script>
<style lang="scss">
.v-slide-group__content .v-btn__content {
  text-transform: capitalize;
}
.task-list {
  gap: 1rem;
}
@media screen and (min-width: 500px) {
  .v-row {
    gap: 1rem;
  }
  .slide-group {
    margin-left: auto !important;
    margin-right: auto !important;
  }
}

@media screen and (max-width: 499px) {
  .v-slide-group__content > .v-btn:not(.active) {
    // display: none;
  }
}
</style>
