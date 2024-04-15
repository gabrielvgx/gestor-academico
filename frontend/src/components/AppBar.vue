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
        {{ getPageTitle() }}
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
    <section class="right-header-slot d-flex align-center justify-end">
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
        </template>
      </v-menu>
      <v-menu>
        <template v-slot:activator="{ props: menu }">
          <v-btn v-bind="menu" icon="mdi-dots-vertical"></v-btn>
        </template>
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
import { ref } from 'vue';
import { EventModule } from '@/util/EventModule.js';

export default {
  emits: ['click'],
  methods: {
    openMenu() {
      console.log('teste');
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
    const isConnected = ref(false);
    const isDevEnv = ref(false);
    const notificationCount = ref(0);
    const submenus = [
      {
        title: 'Servidor do Control',
        name: 'server-control',
        icon: 'mdi-cogs',
      },
      {
        title: 'Banco de Dados',
        name: 'database-control',
        icon: 'mdi-database-settings',
      },
      {
        title: 'Variáveis de Ambiente',
        name: 'environment-control',
        icon: 'mdi-code-tags',
      },
    ];
    return {
      submenus,
      isConnected,
      isDevEnv,
      notificationCount,
      useMobileMenu: window.document.body.clientWidth < 500,
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
