<template>
  <v-app>
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
  position: absolute;
  bottom: 0;
  width: 100vw;
  font-size: small;
  display: flex;
  justify-content: center;
  gap: 1rem;
}
</style>
