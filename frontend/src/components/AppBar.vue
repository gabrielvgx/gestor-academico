<template>
  <v-app-bar :elevation='4' style="position: absolute !important;">
    <div>
      <v-btn v-if="useMobileMenu" icon="mdi-menu" @click="openMenu"></v-btn>
    </div>
    <router-link
      class="home-link d-flex h-100 align-center"
      :to="{ path: '/dashboard' }"
    >
      <v-icon v-if="!useMobileMenu" color="black">mdi-school</v-icon>
      <span v-if="useMobileMenu">
        {{ pageTitle }}
      </span>
      <span v-else>Gestor Acadêmico</span>
    </router-link>
    <!-- <a class="d-flex justify-center" href="/dashboard">
      <v-icon color="black">mdi-school</v-icon>
      <span>Gestor Acadêmico</span>
    </a> -->
    <!-- <div class="font-weight-bold" v-if='isDevEnv'>Ambiente de Desenvolvimento</div>
    <v-chip class="d-none" prepend-icon="mdi-console" append-icon="mdi-console" variant="elevated">
      Ambiente de Desenvolvimento
    </v-chip> -->

    <section class="right-header-slot d-flex align-center justify-end me-3">
      <!-- <v-radio
        :color="isConnected ? 'success' : 'error'"
        :model-value="true"
        :label="isConnected ? 'Conectado' : 'Desconectado'">
      </v-radio> -->
      <v-menu>
        <template v-slot:activator="{ props: notificationMenu }">
          <v-badge :content="notificationCount" :color="notificationCount ? 'error' : 'transparent'" max="99" :dot="!notificationCount">
            <v-btn v-bind="notificationMenu" icon="mdi-bell-outline" density="comfortable" @click="showNotification"></v-btn>
          </v-badge>
          <v-btn icon="mdi-logout" density="comfortable" @click="logout"></v-btn>
        </template>
      </v-menu>
      <v-menu>
        <!-- <template v-slot:activator="{ props: menu }">
          <v-btn v-bind="menu" icon="mdi-dots-vertical"></v-btn>
        </template> -->
        <v-card>
          <v-list>
            <v-list-item
              v-for="(submenu, i) in submenus"
              :key="i"
              :value="submenu"
              color="primary"
              @click="() => appBarClick(submenu)"
            >
              <v-icon :icon="submenu.icon"></v-icon>
              <span class="ps-2">{{ submenu.title }}</span>
            </v-list-item>
          </v-list>
        </v-card>
      </v-menu>
    </section>
  </v-app-bar>
</template>
<script lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { useRoute } from 'vue-router';
import { EventModule } from '@/util/EventModule.js';
import MenuConfig from '@/MenuConfig.js';
import App from '@/util/App';
import Login from '@/controllers/Login';
import '@/controllers/Notification';

export default {
  emits: ['click'],
  methods: {
    logout() {
      EventModule.emit('logout');
    },
    openMenu() {
      EventModule.emit('open-menu');
    },
    appBarClick(submenuItem) {
      this.$emit('click', { action: submenuItem });
    },
    showNotification() {
      this.$emit('click', { action: { name: 'notification' } });
    },
    notificationClick(notification) {
      this.$emit('click', { action: { name: 'notification', notification } });
    },
    getPageTitle() {
      const curPage = window.location.pathname;
      return {
        '/dashboard': 'Dashboard',
        '/user-form': 'Cadastro de Usuário',
        '/week-planning': 'Planejamento Semanal',
        '/material-request': 'Solicitar Material',
      }[curPage];
    }
  },
  setup() {
    const route = useRoute();
    const useMobileMenu = ref(App.isMobile());
    const isConnected = ref(false);
    const isDevEnv = ref(false);
    const notificationCount = ref(0);
    const pageTitle = ref(MenuConfig.getPageName(route.path));
    const submenus = [
      {
        title: 'Configurações',
        name: 'server-control',
        icon: 'mdi-cogs',
      },
    ];
    const onChangePage = ({ path }) => {
      pageTitle.value = MenuConfig.getPageName(path);
    };
    const onResize = () => {
      useMobileMenu.value = App.isMobile();
    };
    onMounted(() => {
      EventModule.on('change-page', onChangePage);
      EventModule.on('confirm-logout', Login.logout);
      window.addEventListener('resize', onResize);
    });
    onUnmounted(() => {
      EventModule.off('change-page', onChangePage);
      EventModule.off('confirm-logout', Login.logout);
      window.removeEventListener('resize', onResize);
    });
    return {
      submenus,
      isConnected,
      isDevEnv,
      notificationCount,
      useMobileMenu,
      pageTitle,
      dialog: ref(false),
    };
  },
};
</script>
<style lang="scss">
  .v-toolbar__content {
    justify-content: space-between !important;
  }
  .v-toolbar__content > * {
    flex: 1;
  }

  .home-link {
    justify-content: center;
    text-decoration: unset;
    color: inherit;
    gap: 1rem;
    font-size: larger;
    // background-color: blue;
    font-weight: bold;
  }

  @media screen and (max-width: 500px) {
    .v-toolbar__content>*:first-child {
      flex: 0;
    }
    .v-toolbar__content>*:nth-child(2) {
      flex: 2;
    }
    .home-link {
      justify-content: start;
    }
  }

  .v-toolbar {
    position: unset!important;
  }
  .right-header-slot {
    gap: 1rem;
  }
</style>
