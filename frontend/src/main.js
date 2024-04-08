/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'
import Notifications from '@kyvg/vue3-notification';

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'

const app = createApp(App)
app.use(Notifications);
registerPlugins(app)

app.mount('#app')
