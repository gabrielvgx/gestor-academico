<template>
  <div :class='slotClass'>
    <!-- v-show='action.showOnlyCheckedRows ? hasSelectedRows : true' -->
    <v-btn v-for='action in actions' :key='action.name' :id='action.name' :prepend-icon='action.icon'
      :class='action.class' :variant='action.variant'
      :color='action.color || `primary`' @click='() => onClick(action)'>
      {{ action.label }}
      <!-- <PopoverMenu v-if='action.popover' :data='action.popover.data' :popover='action.popover' :menu='action'
        :template='action.popover.template' @action:click='(params: any) => popoverClick(action.popover, params)' /> -->
    </v-btn>
  </div>
</template>
<script lang='js'>

// import PopoverMenu from '../views/PopoverMenu.vue';

export default {
  name: 'actions',
  emits: ['action:click' /*, 'popover:click'*/],
  props: ['actions', 'slotClass'],
  // components: {
  //   PopoverMenu,
  // },
  // props: {
  //   hasSelectedRows: {
  //     type: Boolean,
  //     required: false,
  //   },
  //   actions: {
  //     type: Array<any>,
  //     required: true,
  //   },
  //   slotClass: {
  //     type: String,
  //     required: false,
  //   },
  // },
  methods: {
    onClick(action) {
      this.$emit('action:click', action);
    },
    // popoverClick(popoverInfo, { action, data }) {
    //   popoverInfo.data = {};
    //   this.$emit('popover:click', { action, data });
    // },
  },
  setup() { },
};
</script>
<style lang='scss'>
.v-btn {
  text-transform: unset;

}
.v-btn.v-btn--variant-outlined {
  background-color: white;
}
</style>
