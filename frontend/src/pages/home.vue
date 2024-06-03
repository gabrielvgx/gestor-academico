<template>
  <v-container class="pa-0 ma-0 start-section w-100" style="max-width: 100%;">
    <v-app-bar height="50" elevation="0" class="home-app-bar px-6">
      <template v-slot:prepend>
        <v-app-bar-nav-icon @click="drawer = !drawer" v-if="isMobile"></v-app-bar-nav-icon>
        <v-app-bar-title style="font-weight: bold">Gestor Acadêmico</v-app-bar-title>
      </template>

      <template v-slot:append>
        <v-container class="d-flex pa-0 ma-0 w-100 nav-links" v-if="!isMobile">
          <router-link class="page-link" v-for="page in pages" :key="page.name" :to="{ path: page.href }">
            <span style="font-weight: bold">{{ page.label }}</span>
          </router-link>
        </v-container>
      </template>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" temporary>
      <v-list>
        <v-list-item v-for="page in pages" :key="page.name">
          <router-link class="page-link" :to="{ path: page.href }">
            <v-list-item-title>{{ page.label }}</v-list-item-title>
          </router-link>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <!-- <v-container class="pa-0 ma-0">
      <v-card flat color="transparent" rounded >
        <v-img class="teacher-img rounded-lg" src="@/assets/teacher.png"></v-img>
      </v-card>
    </v-container> -->
  </v-container>
  <v-carousel
    progress="primary"
    hide-delimiters
    cycle
    :height="isMobile ? 200 : 500"
    show-arrows="hover"
  >
    <v-carousel-item
      v-for="(slide, i) in slides"
      :key="i"
    >
      <v-sheet>
        <v-img :src="slide.image" cover>
          <div class="text-h3 ma-5 title" :class="slide.textColor ? `text-${slide.textColor}` : 'text-white'">
            {{ slide.title }}
          </div>
          <div class="text-h5 ma-5 description" :class="slide.textColor ? `text-${slide.textColor}` : 'text-white'" style="max-width: 700px">
            {{ slide.description }}
          </div>
        </v-img>
      </v-sheet>
    </v-carousel-item>
  </v-carousel>
  <!-- <v-container class="mx-auto w-100 d-flex justify-center" style="max-width: 100%">
  </v-container> -->
  <v-container class="py-8 w-100 about bg-primary align-center d-flex flex-column" style="max-width: 100%; gap: 1rem">
    <h2>Sobre</h2>
    <v-row class="w-100">
      <v-col cols="12" md="6" lg="6" class="d-flex">
        <span class="text w-100">
          O projeto Gestor Acadêmico propõe uma solução integrada para atender às demandas identificadas pela comunidade escolar da EMEI Alto Vera Cruz,
          visando centralizar as rotinas internas escolares por meio de um portal web. Essa iniciativa busca otimizar processos administrativos e pedagógicos,
          oferecendo uma plataforma para registro de refeições e planejamento escolar, além de facilitar a solicitação de materiais e recusos necessários para o bom funcionamento da escola
        </span>
      </v-col>
      <v-col>
        <v-card flat class="bg-primary">
          <v-img height="300" class="school-img" src="@/assets/emei_picture.jpg" cover></v-img>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
  <hr />
  <v-container class="w-100 py-8 bg-primary" style="max-width: 100%">
    <v-row class="d-flex flex-column align-center">
      <h2 class="ms-2">Funcionalidades</h2>
      <v-col class="d-flex flex-wrap justify-center" style="gap: 1rem">
        <v-card v-for="card in cards" :key="card.name" :elevation="6" style="max-width: 250px" color="white">
          <div class="d-flex flex-column align-center text-center">
            <v-icon class="pa-3" style="min-height: 60px" size="x-large">{{ card.icon }}</v-icon>
            <span class="pa-3" style="min-height: 100px; font-weight: bold;">{{ card.description }}</span>
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script lang="js">
import App from '@/util/App';
import { onUnmounted } from 'vue';
import { onMounted } from 'vue';
import { ref } from 'vue';
import schoolMaterial from '@/assets/school-material.webp';
import schoolPlanning from '@/assets/school-planning.jpg';
import schoolFood from '@/assets/school-food4.webp';

export default {
  setup() {
    const drawer = ref(false);
    const isMobile = ref(App.isMobile());
    const slides = [
      {
        title: 'Material',
        description: 'Gerencie as solicitações de materiais de forma centralizada',
        image: schoolMaterial,
      },
      {
        title: 'Planejamento',
        description: 'Realize o envio de planejamentos para aprovação e obtenha retorno dos mesmos dentro da plataforma',
        image: schoolPlanning,
      },
      {
        title: 'Alimentação',
        description: 'Registre o consumo de alimentos escola para análise de consumo e desperdício',
        image: schoolFood,
        textColor: 'black',
      }
    ];
    const pages = [
      {
        name: 'home',
        label: 'Início',
        href: '/',
      },
      {
        name: 'contact',
        label: 'Contato',
        href: '/contact'
      },
      {
        name: 'login',
        label: 'Login',
        href: '/login'
      },
    ];
    const cards = [
      {
        name: 'planning',
        description: 'Gestão de Planejamento escolar',
        icon: 'mdi-book-alphabet',
      },
      {
        name: 'material',
        description: 'Controle de Solicitações de Materiais',
        icon: 'mdi-toy-brick-plus-outline',
      },
      {
        name: 'notification',
        description: 'Envio de lembretes ao usuários sobre prazos',
        icon: 'mdi-bell-outline',
      },
      {
        name: 'food',
        description: 'Acompanhamento de índices de desperdício alimentar',
        icon: 'mdi-food-apple-outline',
      }
    ];
    const onResize = () => {
      isMobile.value = App.isMobile();
    }
    onMounted(() => {
      window.addEventListener('resize', onResize);
    });
    onUnmounted(() => {
      window.removeEventListener('resize', onResize);
    });
    return {
      pages,
      cards,
      slides,
      drawer,
      isMobile,
    }
  }
}
</script>
<style lang="scss">
.start-section {
  // background-color: var(--light-blue);
}
.home-app-bar {
  display: flex;
  background-color: transparent !important;
  justify-content: space-between;

}
.nav-links {
  gap: 1rem;
  justify-content: flex-end;
}
.page-link {
  color: var(--text-black);
  text-decoration: none;
}
.about {
  text-align: justify;
  font-size: large;
}
.school-img {
  img {
    border-radius: 12px;
  }
}

.teacher-img {
  max-height: 200px;
  border-radius: 50%;
}

@media screen and (max-width: 500px) {
  .title {
    font-size: 2rem !important;
  }
  .description {
    font-size: 1rem !important;
    max-width: 50% !important;
  }
}
</style>
