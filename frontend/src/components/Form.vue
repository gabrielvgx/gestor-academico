<template>
  <v-container class='generic-container'>
    <v-form class="generic-form" ref="form">
      <v-container>
        <slot name='form-body'></slot>
      </v-container>
    </v-form>
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import Rule from '@/util/Rule';
import Login from '@/controllers/Login';

export default {
  name: 'form-component',
  components: {},
  methods: {
    async login() {
      const isValid = await this.$refs.form.validate();
      if (isValid) {
        Login.auth(this.formData);
      }
    },
  },
  setup() {
    const visible = ref(false);
    const formData = ref({
      name: null,
      email: null,
    });
    return {
      visible,
      rules: [
        Rule.required(),
      ],
      formData,
    }
  }
}
</script>
<style lang="scss">
</style>
