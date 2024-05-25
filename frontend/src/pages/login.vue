<template>
  <v-container class="ma-0 pa-0">
    <!-- <v-card-title class="text-h6 font-weight-regular justify-space-between">
      <span>{{ currentTitle }}</span>
    </v-card-title> -->

    <v-window v-model="page">
      <v-window-item value="sign-in">
        <LoginForm @onChangePage="page = 'forgot-password'"/>
        <!-- <h4>teste</h4> -->
      </v-window-item>

      <v-window-item value="otp">
        <OTP />
      </v-window-item>

      <v-window-item value="forgot-password">
        <ForgotPassword />
      </v-window-item>
    </v-window>

    <!-- <v-divider></v-divider> -->

    <!-- <v-card-actions>
      <v-btn
        v-if="step > 1"
        variant="text"
        @click="step--"
      >
        Back
      </v-btn>
      <v-spacer></v-spacer>
      <v-btn
        v-if="step < 3"
        color="primary"
        variant="flat"
        @click="step++"
      >
        Next
      </v-btn>
    </v-card-actions> -->
  </v-container>
</template>
<script lang="js">
import { ref } from 'vue';
import LoginForm from '@/pages/login-form';
import OTP from '@/pages/otp';
import ForgotPassword from '@/pages/forgot-password';

export default {
  components: {
    LoginForm,
    OTP,
    ForgotPassword,
  },
  setup() {
    const page = ref('sign-in'); // 'otp' | 'forgot-password'
    return {
      page,
    }
  }
}

</script>
<style lang="scss"></style>
