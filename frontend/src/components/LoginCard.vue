<template>
  <v-img src="@/assets/background.webp" cover class='pa-0 login-bg'></v-img>
  <v-container class="pa-0 ma-0 card-container">
    <v-btn
      class="mt-3 ms-2"
      icon="mdi-arrow-left"
      variant="text"
      density="small"
      style="position: absolute; z-index: 1"
      @click="() => $router.back()"
    />
    <v-card class="mx-auto px-10 pt-3" elevation="8">
      <v-img src="@/assets/logo.svg" class="mb-8 mx-auto" style="max-width: 250px"></v-img>
      <slot name='content'></slot>
    </v-card>
  </v-container>
</template>

<script lang="js">

export default {
  components: {
  },
  setup() {
  }
}

</script>

<style lang="scss">
.card-container {
  position: absolute;
  right: 0;
  top: 0;
  width: 30%;
  height: 100% !important;
  .v-card {
    height: 100%;
  }
}

/* Estilos para telas pequenas (celulares em orientação retrato) */
@media only screen and (max-width: 600px) {
  .card-container {
    width: 100%;
  }
}

/* Estilos para telas médias (tablets em orientação retrato) */
@media only screen and (min-width: 601px) and (max-width: 992px) {
  .card-container {
    width: 60%;
  }
}

/* Estilos para telas grandes (desktops e tablets em orientação paisagem) */
@media only screen and (min-width: 993px) and (max-width: 1199px) {
  .card-container {
    width: 40%;
  }
}
@media only screen and (min-width: 1200px) {
  .card-container {
    max-width: 500px;
  }
}
</style>
