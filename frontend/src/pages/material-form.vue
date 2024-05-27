<template>
  <v-form ref='form'>
    <v-row>
      <v-col class="py-0" cols="12" lg="6" md="6" sm="12">
        <div class="text-subtitle-1 required">Nome</div>
        <v-text-field
          v-model="formData.name"
          :rules="rules"
          type="text"
          density="compact"
          variant="outlined"
        />
      </v-col>
      <v-col>
        <v-textarea
          v-model="formData.description"
          label="Descrição"
          variant="outlined"
          :rules="rules"
          no-resize
          persistent-placeholder
        />
      </v-col>
    </v-row>
  </v-form>
</template>
<script lang="js">
import Rule from '@/util/Rule';
import { ref } from 'vue';

export default {
  methods: {
    async isValid() {
      const { valid } = await this.$refs.form.validate();
      return valid;
    },
    getValue() {
      return { ...this.formData };
    }
  },
  setup() {
    const formData = ref({
      name: null,
      description: null,
    });
    return {
      formData,
      rules: [Rule.required()],
    }
  }
}
</script>
<style lang="scss"></style>
