<template>
  <v-app>
    <notifications :duration='2000' style='padding-top: 1rem' />
    <v-dialog
      v-model="dialog"
      width="auto"
    >
      <v-card
        max-width="400"
        prepend-icon="mdi-alert-circle-outline"
        text="Deseja realmente sair do sistema?"
        title="Confirmação"
      >
        <template v-slot:actions>
          <v-container class="pa-0 ma-0 d-flex justify-end">
            <v-btn
              text="Não"
              variant="outlined"
              color="primary"
              @click="dialog = false"
            ></v-btn>
            <v-btn
              text="Sim"
              color="primary"
              variant="flat"
              @click="logoutApp"
            ></v-btn>
          </v-container>
        </template>
      </v-card>
    </v-dialog>
    <MobileMenu v-if="useMobileMenu && isAfterLogin" />
    <v-container :class='`container-app ${isAfterLogin ? "after-login" : ""}`'>
      <AppBar v-if="isAfterLogin" />
      <WebMenu v-if="!useMobileMenu && isAfterLogin"></WebMenu>
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
import App from '@/util/App.js';
import { EventModule } from './util/EventModule';
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import { onMounted } from 'vue';
import { onUnmounted } from 'vue';

export default {
  components: {
    AppBar,
    AppFooter,
    WebMenu,
    MobileMenu,
  },
  methods: {
    logoutApp() {
      EventModule.emit('confirm-logout');
    }
  },
  setup() {
    const useMobileMenu = ref(App.isMobile());
    const route = useRoute();
    const logoutDialog = ref(false);
    const routesBeforeLogin = ['/', ...App.getPublicRoutes()];
    const isAfterLogin = ref(!routesBeforeLogin.includes(route.path));
    EventModule.on('change-page', ({ path }) => {
      isAfterLogin.value = !routesBeforeLogin.includes(path);
    });
    EventModule.on('logout', () => {
      logoutDialog.value = true;
    });
    const onResize = () => {
      useMobileMenu.value = App.isMobile();
    }
    onMounted(() => {
      window.addEventListener('resize', onResize);
    });
    onUnmounted(() => {
      window.removeEventListener('resize', onResize);
    });
    return {
      useMobileMenu,
      isAfterLogin,
      dialog: logoutDialog,
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
    height: calc(100vh - var(--header-size) - var(--footer-size));
    // margin-top:  1rem;
    margin-bottom: 1rem;
  }
}
@media screen and (min-width: 500px) {
  .container-app {
    max-width: 100%;
  }
}
</style>
