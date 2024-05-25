<template>
  <v-card class='panel-card ma-2 ms-1'>
    <div class='panel-container'>
      <div class='align-center title-slot' :class="title ? 'd-flex' : 'd-none'">
        <h2 class='color-primary'>{{ title }}</h2>
        <slot name='header'></slot>
      </div>
      <div class='panel-content'>
        <slot name='content'></slot>
      </div>
    </div>
  </v-card>
</template>

<script lang='ts'>
import { ref } from 'vue';

export default {
  props: ['panel'],
  setup(props) {
    const title = ref(props.panel.title);
    return {
      title,
    };
  },
};
</script>
<style lang='scss'>

.v-card,
.v-card--variant-elevated {
  box-shadow: var(--shadow-3) !important;
  margin: var(--default-margin);
}

.panel-card {
  height: calc(100vh - var(--header-size) - var(--footer-size) - var(--gap-header-footer));
  margin-left: 0.15rem;
}

.panel-container {
  padding: 0 var(--default-padding);
  height: 100%;
  overflow-y: auto;
}

.title-slot {
  height: 5vh;
  max-height: 60px;
  padding: 1rem 0;
  h2 {
    margin: 0 !important;
  }
}

.panel-content {
  height: calc(95vh - var(--header-size) - var(--footer-size) - 1rem);
}

.header-actions {
  gap: 1rem;
  justify-content: flex-start;
}

@media screen and (max-width: 500px) {
  .title-slot {
    display: none !important;
  }
  .panel-content {
    margin-top: 1rem;
  }
}

</style>
