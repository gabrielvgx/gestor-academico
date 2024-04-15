<template>
  <v-card :class="`h-100 ${ drawer ? 'w-100' : ''}`"  style="z-index: 2000; position: absolute; background-color: transparent;">
    <v-layout class="h-100">
      <v-navigation-drawer
        v-model="drawer"
        temporary
      >
        <!-- <v-list-item
          prepend-avatar="https://randomuser.me/api/portraits/men/78.jpg"
          title="John Leider"
        ></v-list-item>

        <v-divider></v-divider> -->

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
      <!-- <v-main style="height: 250px">
        <div class="d-flex justify-center align-center h-100">
          <v-btn
            color="primary"
            @click.stop="drawer = !drawer"
          >
            Toggle
          </v-btn>
        </div>
      </v-main> -->
    </v-layout>
  </v-card>
</template>
<script lang="js">
import { EventModule } from '@/util/EventModule.js';
import { onUnmounted, onMounted, ref } from 'vue';
  export default {
    props: ['items'],
    setup(props) {
      const drawer = ref(null);
      const menuItems = ref(props.items);
      const openMenu = () => {
        drawer.value = true;
        console.log('tesste');
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
