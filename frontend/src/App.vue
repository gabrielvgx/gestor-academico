<template>
  <v-app>
    <notifications :duration='2000' style='padding-top: 1rem' />
    <MobileMenu v-if="useMobileMenu" :items="menuItems" />
    <v-container class='container-app'>
      <Menu v-if="!useMobileMenu" :items="menuItems"></Menu>
      <AppBar />
      <v-main class="pa-0">
        <router-view />
      </v-main>
    </v-container>
    <AppFooter />
  </v-app>
</template>

<script setup>
import AppFooter from './components/AppFooter.vue';
import AppBar from './components/AppBar.vue';
import Menu from './components/Menu.vue';
import MobileMenu from './components/MobileMenu.vue';
  //
const useMobileMenu = window.document.body.clientWidth < 500;
const menuItems = [
  {
    name: 'home-page',
    label: 'Início',
    icon: 'mdi-home',
    isMainPage: true,
    href: '/dashboard',
  },
  {
    name: 'week-planning',
    label: 'Planejamento Semanal',
    icon: 'mdi-book-alphabet',
    href: '/week-planning',
  },
  {
    name: 'add-users',
    label: 'Cadastrar usuário',
    icon: 'mdi-account-plus',
    href: '/user-form',
  },
  {
    name: 'add-school',
    label: 'Cadastrar escola / turma',
    icon: 'mdi-home-plus',
    href: '/school-form',
  },
  {
    name: 'material-request',
    label: 'Solicitar material',
    icon: 'mdi-toy-brick-plus',
    href: '/material-request',
  },
]
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
