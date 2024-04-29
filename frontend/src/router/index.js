
/**
 * router/index.ts
 *
 * Automatic routes for `./src/pages/*.vue`
 */

// Composables
import { EventModule } from '@/util/EventModule';
import { createRouter, createWebHistory } from 'vue-router/auto'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem('token');

  if (!isAuthenticated && to.path !== '/login') {
    next('/login');
  } else {
    next();
  }
});

router.afterEach((params) => {
  const { path } = params;
  EventModule.emit('change-page', { path });
});

export default router
