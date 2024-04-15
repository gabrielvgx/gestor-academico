<template>
  <v-app>
    <notifications :duration='2000' style='padding-top: 1rem' />
    <MobileMenu v-if="useMobileMenu" :items="menuItems" />
    <v-container class='container-app'>
      <WebMenu v-if="!useMobileMenu" :items="menuItems"></WebMenu>
      <AppBar v-if="showAppBar()" />
      <v-main class="pa-0">
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

export default {
  components: {
    AppBar,
    AppFooter,
    WebMenu,
    MobileMenu,
  },
  methods: {
    showAppBar() {
      this.$router.afterEach(params => console.log(params));
      return !(['/', '/login'].includes(this.$route.path));
    }
  },
  setup() {
    const useMobileMenu = App.isMobile();
    const menuItems = MenuConfig.getAll();
    return {
      useMobileMenu,
      menuItems,
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
  height: calc(100vh - var(--header-size) - var(--footer-size));
}
</style>
