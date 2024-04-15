<template>
  <div class="menu-app d-flex flex-column">
    <div class="menu-slot" v-for="menu in menuItems" :key="menu.name" :class="menu.isActive ? 'active-menu' : ''" @click="() => menuClick(menu, menuItems)">
      <!-- MenuItem without submenu's -->
      <v-tooltip v-if="showToolTip(menu)" :text="'teste'" right content-class="menu-tooltip">
        <template v-slot:activator="{ on, props }">
          <!-- <v-btn variant="text" tile icon v-bind="props" v-on="on" :link="true" :to="getMenuLink(menu)">
            <v-icon>
              {{ menu.icon }}
            </v-icon>
          </v-btn> -->
          <router-link
            class="menu-link"
            :to="{ path: getMenuLink(menu) }"
            v-bind="props"
            v-on="on"
          >
            <v-icon>{{ menu.icon }}</v-icon>
          </router-link>
        </template>
        <span>{{ menu.label }}</span>
      </v-tooltip>

      <!-- MenuItem with submenu's -->
      <v-btn v-else tile icon>
        <!-- <v-icon class="menu-item">
          {{ menu.icon }}
        </v-icon> -->
        <!-- <template v-slot:activator="{ on, attrs }"> -->
          <v-btn tile icon :link="true" :to="getMenuLink(menu)">
            <v-icon>
              {{ menu.icon }}
            </v-icon>
          </v-btn>
        <!-- </template> -->
        <div class="submenu" v-if="Array.isArray(menu.submenu) && menu.submenu.length">
          <ul class="elevation-9">
            <li
              v-for="submenu in menu.submenu"
              :key="submenu.name"
              class="prevent-select"
              :class="submenu.isHeader ? 'submenu-header' : ''"
            >
              <router-link :to="dynamicRoute(submenu)">{{ submenu.label }}</router-link>
            </li>
          </ul>
        </div>
      </v-btn>
    </div>

  </div>
</template>

<script lang="js">
import { ref } from 'vue';
import Menu from '@/controllers/Menu.js';

export default {
  name: 'MenuApp',
  props: ['items'],
  methods: {
    hasSubMenu(menu, subMenuToFind) {
      if(!Array.isArray(menu.submenu)) return false;
      return menu.submenu.some(submenu => submenu.name === subMenuToFind);
    },
    menuClick(menu, menuItems) {
      menuItems.forEach((curMenu) => {
        curMenu.isActive = curMenu.name === menu.name || this.hasSubMenu(curMenu, menu.name);
      });
    },
    getMenuLink(menu){
      if(Array.isArray(menu.submenu) && menu.submenu.length) {
        const submenu = menu.submenu.find(submenu => !submenu.isHeader && submenu.href);
        if(submenu) {
          return submenu.href;
        }
      }
      return menu.href || window.location.href;
    },
    showToolTip(menu) {
      return !Array.isArray(menu.submenu) || menu.submenu.length === 0;
    },
    dynamicRoute(submenu) {
      return { path: submenu.href }
    },
  },
  setup(props) {
    const menu = [...Menu.getMenuWithAccessControl(props.items)];
    Menu.setDefaultIsActive(menu);
    const menuItems = ref(menu);
    return {
      menuItems,
    };
  },
};
</script>

<style lang="scss">

.v-tooltip__content {
  background: var(--zd-font-color) !important;
}

.menu-app {
  margin-top: var(--header-size);
}

.menu-app div.v-tooltip__content.menuable__content__active {
  opacity: 1 !important;
}

.menu-tooltip.v-tooltip__content::before {
  position: relative;
  content: '';
  display: inline-block;
  left: -0.25rem;
  border-top: 0.25rem solid transparent;
  border-bottom: 0.25rem solid transparent;
  border-right: 0.25rem solid var(--zd-font-color);
  border-right-color: var(--zd-font-color);
}

.menu-app {
  gap: 0.25rem;
  --selected-bg-color: rgba(41, 41, 97, 0.08);
  margin-left: 0.5rem;
  padding-right: 0.5rem;
  box-shadow: 4px 0 5px -4px #888;

  // .active-menu a > span.v-btn__content {
  //   color: var(--v-primary-base) !important;
  // }
  .active-menu {
    background-color: var(--v-primary-base) !important;
    color: var(--white) !important;
  }

  li::marker {
    content: ''
  }

  .submenu {
    display: none;

    li {
      text-align: start;
    }
  }

  a, button {
    color: var(--zd-font-color) !important;
  }

  // .v-btn {
  //   text-transform: none;
  // }

  .menu-slot {
    padding: 0.5rem;
    border-radius: 0.25rem;
  }

  .menu-slot:first-child {
    margin-top: 0.75rem;
  }
  .menu-slot:hover {
    background-color: var(--selected-bg-color);
    border-radius: 5px;
  }

  .menu-item {
    border-radius: 5px;
  }

  .menu-item:hover ~ .submenu, .menu-slot:hover .submenu {
    display: block;
    position: fixed;
    left: 2.75rem;
    z-index: 999;
  }

  .menu-item:hover ~ .submenu > ul, .menu-slot:hover .submenu > ul {
    background-color: white;
    margin-left: 1rem;
    border: solid 1px lightgrey;
    border-top: 0;
    border-radius: 6px;
    padding-left: 0;

    li {
      border-radius: 6px 6px 0 0;
    }
  }

  .menu-slot:hover .submenu-header {
    font-weight: bold;
    background-color: var(--ligh-gray);
  }

  .menu-item:hover ~ .submenu li > a, .menu-slot:hover li > a {
    padding: 0.5rem 0.75rem;
    margin: 0.25rem 0.5rem;
    display: block;
  }

  .menu-item:hover ~ .submenu li:not(.submenu-header), .menu-slot:hover .submenu li:not(.submenu-header) {
    border-radius: 0.25rem;
  }

  .menu-item:hover ~ .submenu li:not(.submenu-header):hover a, .menu-slot:hover .submenu li:not(.submenu-header):hover a {
    background-color: var(--selected-bg-color);
    border-radius: 0.25rem;
  }
  // .menu-link {
  //   padding: 0.5rem;
  //   border-radius: 0.25rem;
  // }
}

</style>
