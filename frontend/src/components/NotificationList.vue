<template>
  <v-card id='notification-bar' class='notification-card ma-0'>
    <v-layout class='layout'>
      <v-navigation-drawer
        class='drawer'
        v-model="opened"
        temporary
        width="312"
        location="right"
      >
        <div class="title-bar">
          <v-icon>mdi-bell-outline</v-icon>
          <span>Lembretes do dia</span>
        </div>
        <v-divider></v-divider>
        <!-- <div v-if="notifications.length" class="notification-actions align-center" style="margin-top: auto; margin-bottom: auto;">
          <v-btn
            :rounded="0"
            flat
            size="x-large"
            color="primary"
            @click="alreadyReadAll"
          >
            <v-icon>mdi-check-circle-outline</v-icon>
            <span>Marcar todas como lida</span>
          </v-btn>
          <v-btn
            :rounded="0"
            flat
            size="x-large"
            color="error"
            @click="removeAllNotification"
          >
            <v-icon>mdi-delete</v-icon>
            <span>Remover todas</span>
          </v-btn>
        </div> -->
        <div v-if="loader">
          <v-skeleton-loader type="paragraph"></v-skeleton-loader>
        </div>
        <div v-else style="max-height: calc(100vh - 100px - 1rem); overflow-y: auto;">
          <div v-if='notifications.length === 0' class='empty-notifications'>
            <span>Sem lembretes no momento</span>
          </div>
          <v-list class="notification-list" density="compact" nav v-else>
            <v-list-item
                :elevation="1"
                v-for="(listItem, i) in notifications"
                :key="i"
                :value="listItem"
                color="primary"
                :class='`notification ${listItem.type}`'
                @click="(ev) => notificationClick(listItem, ev)"
              >
                <div class="d-flex">
                  <!-- <div class="before-notification green"></div> -->
                  <div class="content">
                    <div class="title text-center already-read">
                      <!-- <v-btn class="already-read" icon density="compact" size="x-small" flat @click="() => toggleAlreadyRead(listItem)">
                        <v-tooltip activator="parent" :model="true" location="bottom">{{`Marcar como ${listItem.isAlreadyRead ? 'não ' : ''}lida`}}</v-tooltip>
                        <v-icon class="already-read" color='primary' size="x-small">{{ listItem.isAlreadyRead ? 'mdi-circle-outline' : 'mdi-circle'}}</v-icon>
                      </v-btn> -->
                      <!-- <v-chip variant="flat" size="small" color="green">{{ listItem.title }}</v-chip> -->
                      <span class="ps-2 font-weight-bold">{{ listItem.title }}</span>
                    </div>
                    <div class="description">
                      <span>{{ listItem.description }}</span>
                    </div>
                    <!-- <div class="footer">
                      <span class="ps-2">
                        {{ footerTime[listItem.id] }}
                        <v-tooltip activator="parent" :model="true" v-if="!!listItem.tooltipFooter" location="bottom">{{ listItem.tooltipFooter }}</v-tooltip>
                      </span>
                    </div> -->
                  </div>
                </div>
                <!-- <v-divider class='mt-1'></v-divider> -->
            </v-list-item>
          </v-list>
        </div>
      </v-navigation-drawer>
    </v-layout>
  </v-card>
</template>
<script lang='js'>
import { ref, onUnmounted } from 'vue';
import { EventModule } from '@/util/EventModule';
import Notification from '@/controllers/Notification';
// import Alert from '@/util/Alert';
// import ms from 'ms';
// import { useRoute } from 'vue-router';

  export default {
    methods: {
      notificationClick(notification, event) {
        const stopEvent = event && event.target && event.target.classList.contains('already-read');
        if (!stopEvent) {
          // if (notification.status === 'REPORT_PENDING') {
          //   return Alert.showInfo('Seu relatório ainda esta em processamento.');
          // }
          this.$emit('notification:click', { notification });
          // if (!notification.isAlreadyRead) {
          //   this.toggleAlreadyRead(notification);
          // }
        }

      },
      // async toggleAlreadyRead(notification) {
      //   try {
      //     const {
      //       id,
      //       isAlreadyRead,
      //     } = notification;

      //     const updated = await Notification.toggleAlreadyRead(id, !isAlreadyRead);
      //     if (updated) {
      //       notification.isAlreadyRead = !notification.isAlreadyRead;
      //       EventModule.emit('notification', {
      //         action: notification.isAlreadyRead ? 'remove' : 'add',
      //       });
      //     }
      //   } catch (err) {
      //     console.error(err);
      //   }
      // },
      // async removeAllNotification() {
      //   Notification.removeAllNotifications().then(() => {
      //     this.notifications = [];
      //     EventModule.emit('notification', { action: 'change', value: 0 });
      //   });
      // },

      // async alreadyReadAll() {
      //   Notification.checkAllNotifications().then(() => {
      //     this.notifications.forEach(item => item.isAlreadyRead = true);
      //     EventModule.emit('notification', { action: 'change', value: 0 });
      //   });
      // },
    },
    emits: ['notification:click'],
    setup(props, { emit }) {

      // const route = useRoute();
      const notifications = ref([]);
      const opened = ref(false);
      const preview = ref(false);
      const loader = ref(true);
      const interval = ref(setInterval(async() => {
        notifications.value = await Notification.load();
        loader.value = false;
      }, 10*1000));

      onUnmounted(() => {
        clearInterval(interval.value);
      })

      const footerTime = ref({});
      // setTimeout(() => {
      //   opened.value = !opened.value;
      // }, 5000);
      const openNotificationBar = () => {
        opened.value = true;
      };
      // const createIntervalFooter = (notification) => {
      //   intervals.value[notification.id] = Notification.createFooterTimeInterval(notification, {
      //     callbackFn: (elapsedTime) => {
      //       footerTime.value[notification.id] = elapsedTime;
      //     },
      //   });
      // };
      // Notification.list().then((rows) => {
      //   notifications.value = rows;
      //   loader.value = false;
      //   let unreadNotifications = 0;
      //   rows.forEach((row) => {
      //     if (!row.isAlreadyRead) {
      //       unreadNotifications++;
      //     }
      //     createIntervalFooter(row);
      //   });
      //   EventModule.emit('notification', { action: 'change', value: unreadNotifications });
      // });
      const handleCloseNotificationBar = (event) => {
        const element = event.target;
        const notificationBarEl = document.getElementById('notification-bar');
        if (notificationBarEl && element && !notificationBarEl.contains(element) && !preview.value) {
          opened.value = false;
        }
      };
      // const changePreviewStatus = (status) => {
      //   preview.value = !!status;
      // };
      // const handleNotification = ({ action, notification }) => {
      //   const record = action === 'update' ? notifications.value.find(row => row.id === notification.id) : null;
      //   if (action === 'add' || (action === 'update' && !record)) {
      //     notifications.value.unshift(notification);
      //     createIntervalFooter(notification);
      //     EventModule.emit('notification', {
      //       action: 'add',
      //     });
      //   } else if (action === 'update' && record) {
      //     const updatedNotification = Object.assign(record, notification);
      //     const lastUpdate = new Date(updatedNotification.updatedAt);
      //     const reportGenerated = updatedNotification.status === 'REPORT_GENERATED';
      //     if (reportGenerated && route.path === '/report' && (Date.now() - lastUpdate.getTime()) < ms('5s')) {
      //       record.isAlreadyRead = true;
      //       Notification.toggleAlreadyRead(updatedNotification.id, true);
      //       EventModule.emit('notification', { action: 'remove' });
      //       emit('notification:click', { notification: updatedNotification });
      //     }
      //   }
      // };
      onUnmounted(() => {
        document.removeEventListener('click', handleCloseNotificationBar);
        EventModule.off('openNotificationBar', openNotificationBar);
      //   EventModule.off('notificationPreview', changePreviewStatus);
      //   EventModule.off('notification-list', handleNotification);
      //   Object.values(intervals.value).forEach(clearInterval);
      });
      document.addEventListener('click', handleCloseNotificationBar);
      EventModule.on('openNotificationBar', openNotificationBar);
      // EventModule.on('notificationPreview', changePreviewStatus);
      // EventModule.on('notification-list', handleNotification);

      return {
        opened,
        notifications,
        preview,
        loader,
        // intervals,
        footerTime,
      };
    },
  };
</script>

<style lang='scss'>
.notification-list {
  gap: 0.25rem;
  display: flex;
  flex-direction: column;
}

.notification-actions {
  display: flex;
  .v-btn__content {
    flex-direction: column;
    font-size: small;
    span {
      white-space: break-spaces;
    }
  }
  button {
    flex: 1;
  }
}

.notification {
  padding-left: 0;
  border-radius: 0.5rem;
  border-width: 0 0 0 0.5rem;
  background-color: #FAF9F9;
}

.notification.success {
  border-color: var(--green-text);
}

.notification.warn {
  border-color: var(--yellow-text);
}

.notification.error {
  border-color: var(--red-text);
}

.notification-card {
  z-index: 1007;
}
.notification .content {
  display: flex;
  flex-direction: column;
  width: 100%;
  /*
  .title {
    flex-direction: row-reverse;
    justify-content: space-between;
  }
  */
  .footer {
    color: var(--gray-text);
    margin-top: 0.5rem;
  }
  .title, .description, .footer {
    width: 100%;
    display: flex;
  }
  .description {
    padding-left: 0.5rem;
  }
  .footer {
    justify-content: end;
    font-size: small;
  }
}

.title-bar {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--default-padding);
  gap: 1rem;
}
.empty-notifications {
  color: var(--gray-text);
  padding: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.9rem;
}
.before-notification {
  width: 5px;
  margin-right: 5px;
  border-radius: 48px;
}
.before-notification.green {
  background-color: var(--green-text);
}
.before-notification.red {
  background-color: var(--red-text);
}
.before-notification.yellow {
  background-color: var(--yellow-text);
}
</style>
