const config = [
  {
    name: 'home-page',
    label: 'Início',
    icon: 'mdi-home-variant-outline',
    selectedMenuIcon: 'mdi-home',
    isMainPage: true,
    href: '/dashboard',
  },
  {
    name: 'week-planning',
    label: 'Planejamento Semanal',
    icon: 'mdi-book-alphabet',
    href: '/planning-management',
    permissions: ['TEACHER'],
  },
  {
    name: 'planning-management',
    label: 'Planejamentos',
    icon: 'mdi-book-settings-outline',
    selectedMenuIcon: 'mdi-book-settings',
    href: '/planning-management',
    permissions: ['SUPERVISOR'],
  },
  {
    name: 'material-request',
    label: 'Materiais Solicitados',
    icon: 'mdi-clipboard-list-outline',
    selectedMenuIcon: 'mdi-clipboard-list',
    href: '/material-management',
    permissions: ['SUPERVISOR'],
  },
  {
    name: 'material',
    label: 'Materiais',
    icon: 'mdi-toy-brick-outline',
    selectedMenuIcon: 'mdi-toy-brick',
    href: '/material',
    permissions: ['SUPERVISOR']
  },
  {
    name: 'add-users',
    label: 'Usuários',
    icon: 'mdi-account-outline',
    selectedMenuIcon: 'mdi-account',
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
    href: '/material-management',
    permissions: ['TEACHER'],
  },
  {
    name: 'food-record',
    label: 'Registro Alimentar',
    icon: 'mdi-food-apple-outline',
    selectedMenuIcon: 'mdi-food-apple',
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
