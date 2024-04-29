<template>
  <v-container class='food-container generic-container'>
    <v-form class="food-form generic-form" ref="form">
      <v-row class="form-title">
        <h3>Registro Alimentar</h3>
      </v-row>
      <div v-for="(_, idx) in formData.foodRecords" v-bind:key="`class_${idx}`">
        <!-- <div class="text-subtitle-1 required">Nome da Turma {{ formData.foodRecords.length > 1 ? idx + 1 : ''  }}</div> -->
        <!-- <div class="text-subtitle-1 required">Turno</div>
        <v-text-field
            v-model="formData.foodRecords[idx].period"
            type="text"
            density="compact"
            placeholder="Ex.: Novo Amanhecer"
            variant="outlined"
        /> -->
        <v-select
          class="required"
          :rules="rules"
          label="Tipo de Refeição"
          :items="['Café da Manhã', 'Almoço', 'Refeição da Tarde (Lanche)', 'Jantar (PU)']"
          density="comfortable"
          variant="underlined"
        ></v-select>
        <div class="d-flex flex-column">
          <div v-for="(classRecord, classIdx) in classCollection" :key='`class_${classIdx}`'>
            <v-row>
              <h4>{{ classRecord.className }}</h4>
            </v-row>
            <v-row>
              <v-text-field
                v-model="formData.foodRecords[idx].consumer"
                type="text"
                density="compact"
                label="Nº de Comensais"
                variant="outlined"
              />
            </v-row>
          </div>
          <!-- <v-text-field
              v-model="formData.foodRecords[idx]"
              type="text"
              density="compact"
              placeholder="Ex.: Novo Amanhecer"
              variant="outlined"
          ></v-text-field>
          <v-btn class="ms-3" color="success" icon="mdi-plus" density="comfortable" @click="() => formData.foodRecords.push(null)"></v-btn>
          <v-btn v-if="idx > 0" class="ms-2" color="error" icon="mdi-delete-outline" density="comfortable" @click="() => formData.foodRecords.splice(idx, 1)"></v-btn> -->
        </div>
      </div>
    </v-form>
  </v-container>
</template>

<script lang="js">
import { ref } from 'vue';

export default {
  setup() {
    const formData = ref({
      foodRecords: [{
        period: '',
      }],
    })
    return {
      formData,
      classCollection: [
        {
          className: 'Turma 1 e 2 anos'
        },
        {
          className: 'Turma 3, 4 e 5 anos'
        },
        {
          className: 'Funcionários'
        }
      ],
    }
  }
}
</script>

<style></style>
