<template>
  <v-app>
    <notifications :duration='2000' style='padding-top: 1rem' />
    <v-main>
      <router-view />
      <AppFooter />
    </v-main>
  </v-app>
</template>

<script setup>
import AppFooter from './components/AppFooter.vue';
  //
</script>
<style lang="scss" scoped>
.v-footer {
  height: 30px;
  position: absolute;
  bottom: 0;
  width: 100vw;
  font-size: small;
  display: flex;
  justify-content: center;
  gap: 1rem;
}
</style>
