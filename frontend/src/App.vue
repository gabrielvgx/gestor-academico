<template>
  <v-app>
    <notifications :duration='2000' style='padding-top: 1rem' />
    <MobileMenu v-if="useMobileMenu" :items="menuItems" />
    <v-container :class='`container-app ${isAfterLogin ? "after-login" : ""}`'>
      <WebMenu v-if="!useMobileMenu && isAfterLogin" :items="menuItems"></WebMenu>
      <AppBar v-if="isAfterLogin" />
      <v-main :class='`pa-0 ${isAfterLogin ? "after-login" : ""}`'>
        <router-view />
      </v-main>
    </v-container>
    <AppFooter />
  </v-app>
</template>

<script lang="js">
import AppFooter from './components/AppFooter.vue';
import AppBar from './components/AppBar.vue';
import WebMenu from './components/Menu.vue';
import MobileMenu from './components/MobileMenu.vue';
import MenuConfig from '@/MenuConfig.js';
import App from '@/util/App.js';
import { EventModule } from './util/EventModule';
import { ref } from 'vue';
import { useRoute } from 'vue-router';

export default {
  components: {
    AppBar,
    AppFooter,
    WebMenu,
    MobileMenu,
  },
  methods: {
    // isAfterLogin() {
    //   return !(['/', '/login'].includes(this.$route.path));
    // }
  },
  setup() {
    const useMobileMenu = App.isMobile();
    const menuItems = MenuConfig.getAll();
    const route = useRoute();
    const isAfterLogin = ref(!['/', '/login'].includes(route.path));
    EventModule.on('change-page', ({ path }) => {
      isAfterLogin.value = !['/', '/login'].includes(path);
    })
    return {
      useMobileMenu,
      menuItems,
      isAfterLogin,
    }
  }
}
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
.container-app {
  display: flex;
  margin: 0;
  padding: 0;
  margin-top: calc(var(--header-size));
  .v-main {
    height: calc(100vh - var(--header-size) - var(--footer-size) - 2rem);
    margin-top:  1rem;
    margin-bottom: 1rem;
  }
}
@media screen and (min-width: 500px) {
  .container-app {
    max-width: 100%;
  }
}
</style>
