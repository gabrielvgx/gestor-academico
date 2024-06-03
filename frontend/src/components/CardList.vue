<template>
  <v-container class="pa-0 my-3 d-flex flex-wrap justify-center align-items-center" style="gap: 1rem">
    <v-card class='card ma-0' v-for='card in cards' :key='card.name' :color='card.color' :class="card.isVisible !== false ? 'd-flex' : 'd-none'">
      <v-row class="ma-0 pa-0 h-100" @click="() => $emit('onClick', card)">
        <v-col cols='2' md='2' sm='12' class='d-flex align-center justify-center card-icon'>
          <v-icon :icon='card.icon'></v-icon>
        </v-col>
        <v-col class='d-flex' md="10">
          <v-row class='my-0 align-center card-info'>
            <v-col class='d-flex py-0 my-0 justify-center title-card prevent-select'>{{ card.title }}</v-col>
            <v-col class='py-0 text-center left-slot' cols='12'>{{ card.content }}</v-col>
            <v-col class='py-0 text-align-end right-slot'>{{ card.footer }}</v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-card>
  </v-container>
</template>
<script lang="js">
export default {
  props: ['data'],
  emits: ['onClick'],
  setup(props) {
    return {
      cards: props.data,
    }
  }
}
</script>
<style lang="scss">
.card {
  flex-grow: 1;
  flex-basis: 0;
  max-width: min(100%, 300px);
  min-width: 250px;
  cursor: pointer;
  .title-card {
    font-size: 1rem;
  }

  .right-slot {
    font-size: 1rem;
  }

  .v-card-item {
    border-bottom: solid;
  }

  .v-label {
    margin: 0.5rem 0;
  }

  .card-icon {
    width: clamp(30px, 25%, 50px) !important;
  }

  .card-info {
    font-size: 1.5rem;
  }
}

.text-align-end {
  text-align: end;
}

.title-slot {
  display: none;
}

@media screen and (min-width: 960px) {
  .card {
    .card-icon {
      border-right: solid;
    }
  }
}

@media screen and (max-width: 959px) {
  .card {
    .card-icon {
      border-bottom: solid;
    }
  }
}

@media screen and (max-width: 600px) {
  .card {
    .card-icon {
      border-right: solid;
      border-bottom: none;
    }
  }
}
</style>
