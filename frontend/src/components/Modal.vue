<template>
  <!-- <v-row justify='center'> -->
    <v-dialog :model-value='true' :class='`modal ${name}`' @update:modelValue='changeValue'>
      <v-card class='px-5 ma-0'>
        <v-row style="max-height: 10%;" class="ma-0 mt-2 mb-4">
          <v-col class='ma-0 pa-0'>
            <v-label class='modal-title'>
              {{ modal?.title || '' }}
            </v-label>
          </v-col>
          <v-col class='pa-0'>
            <slot name='modal-header'></slot>
          </v-col>
          <v-col class='d-flex justify-end pa-0'>
            <v-btn icon='mdi-window-close' color='primary' variant='text' density='compact'
              @click='closeModal'></v-btn>
          </v-col>
        </v-row>
        <div class='modal-body'>
          <slot name='content'></slot>
        </div>

        <Actions slotClass='d-flex justify-end modal-actions' :actions='actions' @action:click='onClickAction' />

      </v-card>
    </v-dialog>
  <!-- </v-row> -->
</template>

<script lang='js'>
import { ref, onMounted, onUnmounted } from 'vue';
import Actions from './Actions';

export default {
  components: {
    Actions,
  },
  emits: ['action:click', 'close', 'confirm', 'cancel'],
  props: ['modal'],
  methods: {
    onClickOutside() {
      this.$emit('close');
    },
    changeValue() {
      return false;
    },
    onClickAction(action) {
      this.$emit('action:click', { action });
      if (['confirm', 'cancel'].includes(action.name)) {
        this.$emit(action.name, { action });
      }
      if (action.name === 'cancel') {
        this.$emit('close', { action: 'close' });
      }
    },
    closeModal() {
      this.$emit('close', { action: 'close' });
    },
  },
  setup(props, { emit }) {
    let actions = null;
    const listenEscKey = (ev) => {
      if (ev.key === 'Escape') {
        emit('close');
      }
    };
    onMounted(() => {
      window.addEventListener('keyup', listenEscKey);
    });
    onUnmounted(() => {
      window.removeEventListener('keyup', listenEscKey);
    });
    if (props.modal && Array.isArray(props.modal.actions)) {
      actions = ref(props.modal.actions);
    } else if (!props.modal.hideFooter) {
      actions = ref([
        {
          name: 'cancel',
          label: 'Cancelar',
          class: 'mx-2 my-3',
          variant: 'outlined',
        },
        {
          name: 'confirm',
          label: 'Confirmar',
          class: 'mx-2 my-3',
        },
      ]);
    } else {
      actions = ref([]);
    }
    return {
      actions,
      name: props.modal.name || ''
    };
  },
};
</script>

<style lang='scss'>
.modal {
  width: var(--default-modal-width) !important;
  .v-overlay__content > .v-card {
    margin-bottom: var(--modal-footer-height);
    height: 80vh !important;
  }
}
.modal-title {
  font-size: 1rem !important;
  color: var(--v-primary-base);
}
</style>
