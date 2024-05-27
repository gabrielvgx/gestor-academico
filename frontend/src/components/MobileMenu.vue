<template>
  <v-card :class="`h-100 ma-0 ${ drawer ? 'w-100' : ''}`"  style="z-index: 2000; position: absolute; background-color: transparent;">
    <v-layout class="h-100">
      <v-navigation-drawer
        v-model="drawer"
        temporary
      >
        <v-list density="compact" nav>
          <v-list-item
            v-for="(menu, idx) in menuItems"
            :key="idx"
            :prepend-icon="menu.icon"
            :title="menu.label"
            :value="menu.href"
            @click="() => { this.$router.push(menu.href) }"
          ></v-list-item>
        </v-list>
      </v-navigation-drawer>
    </v-layout>
  </v-card>
</template>
<script lang="js">
import AccessControl from '@/util/AccessControl';
import { EventModule } from '@/util/EventModule.js';
import { onUnmounted, onMounted, ref } from 'vue';
  export default {
    setup() {
      const drawer = ref(null);
      const menuItems = ref(AccessControl.getMenu());
      const openMenu = () => {
        drawer.value = true;
      };
      onMounted(() => {
        EventModule.on('open-menu', openMenu);
      });
      onUnmounted(() => {
        EventModule.off('open-menu', openMenu);
      })
      return {
        drawer,
        menuItems,
      }
    }
  }
</script>
