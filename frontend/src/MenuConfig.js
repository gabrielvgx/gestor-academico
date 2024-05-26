const config = [
  {
    name: 'home-page',
    label: 'Início',
    icon: 'mdi-home',
    isMainPage: true,
    href: '/dashboard',
  },
  {
    name: 'week-planning',
    label: 'Planejamento Semanal',
    icon: 'mdi-book-alphabet',
    href: '/week-planning',
    permissions: ['TEACHER'],
  },
  {
    name: 'planning-management',
    label: 'Planejamentos',
    icon: 'mdi-book-settings-outline',
    href: '/planning-management',
    permissions: ['SUPERVISOR'],
  },
  {
    name: 'material',
    label: 'Materiais',
    icon: 'mdi-format-list-bulleted-square',
    href: '/material',
    permissions: ['SUPERVISOR']
  },
  {
    name: 'add-users',
    label: 'Usuários',
    icon: 'mdi-account',
    href: '/user',
    permissions: ['SUPERVISOR'],
  },
  {
    name: 'add-school',
    label: 'Escolas e Turmas',
    icon: 'mdi-town-hall',
    href: '/school',
    permissions: ['SUPERVISOR'],
  },
  {
    name: 'material-request',
    label: 'Solicitar material',
    icon: 'mdi-toy-brick-plus',
    href: '/material-request',
    permissions: ['TEACHER'],
  },
  {
    name: 'food-record',
    label: 'Registro Alimentar',
    icon: 'mdi-food-fork-drink',
    href: '/food-record',
    permissions: ['KITCHEN'],
  },
  {
    name: 'settings',
    label: 'Parametrização do Sistema',
    icon: 'mdi-cogs',
    href: '/settings',
    permissions: ['SUPERVISOR'],
  },
];

class MenuConfig {

  getAll() {
    return config;
  }

  getPageName(path) {
    const menu = this.getAll().find(row => row.href === path);
    return menu ? menu.label : 'Início';
  }
}

export default new MenuConfig;
