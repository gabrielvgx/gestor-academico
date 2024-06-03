<template>
  <NotificationList />
  <v-app style="overflow-y: auto; overflow-x: hidden; max-height: calc(100vh - var(--footer-size))">
    <notifications :duration='2000' style='padding-top: 1rem' />
    <v-dialog
      v-model="dialog"
      width="auto"
    >
      <v-card
        max-width="400"
        prepend-icon="mdi-alert-circle-outline"
        :text="dialogText"
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
              @click="confirmDialog"
            ></v-btn>
          </v-container>
        </template>
      </v-card>
    </v-dialog>
    <MobileMenu v-if="useMobileMenu && isAfterLogin" />
    <v-container :class='`container-app ${isAfterLogin ? "after-login" : ""}`'>
      <AppBar v-if="isAfterLogin" @click="openNotification"/>
      <WebMenu v-if="!useMobileMenu && isAfterLogin"></WebMenu>
      <v-main :class='`pa-0 ${isAfterLogin ? "after-login" : ""}`'>
        <router-view />
      </v-main>
    </v-container>
    <AppFooter />
  </v-app>
</template>

<script lang="js">
import AppFooter from './components/AppFooter';
import AppBar from './components/AppBar';
import WebMenu from './components/Menu';
import MobileMenu from './components/MobileMenu';
import NotificationList from './components/NotificationList';
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
    NotificationList,
  },
  methods: {
    confirmDialog() {
      EventModule.emit(this.callbackEventDialog);
      this.dialog = false;
    },
    openNotification({ action }) {
      console.log(action);
      if (action.name === 'notification') {
        EventModule.emit('openNotificationBar');
      }
    }
  },
  setup() {
    const useMobileMenu = ref(App.isMobile());
    const route = useRoute();
    const dialog = ref(false);
    const dialogText = ref('');
    const callbackEventDialog = ref('');
    const routesBeforeLogin = ['/', ...App.getPublicRoutes()];
    const isAfterLogin = ref(!routesBeforeLogin.includes(route.path));
    EventModule.on('change-page', ({ path }) => {
      isAfterLogin.value = !routesBeforeLogin.includes(path);
    });
    EventModule.on('confirmMessage', ({ event, message }) => {
      dialogText.value = message;
      dialog.value = true;
      callbackEventDialog.value = event;
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
      dialog,
      dialogText,
      callbackEventDialog,
    }
  }
}
</script>
<style lang="scss" scoped>
.v-footer {
  height: 30px;
  position: fixed;
  bottom: 0;
  width: 100vw;
  font-size: small;
  display: flex;
  justify-content: center;
  gap: 1rem;
}
.container-app.after-login {
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

.container-app:not(.after-login) {
  margin: 0;
  padding: 0;
  .v-main {
    height: 100vh;
  }
}

@media screen and (min-width: 500px) {
  .container-app {
    max-width: 100%;
  }
}
</style>
