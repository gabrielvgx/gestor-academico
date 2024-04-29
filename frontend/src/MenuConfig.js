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
  },
  {
    name: 'add-users',
    label: 'Cadastrar usuário',
    icon: 'mdi-account-plus',
    href: '/user-form',
  },
  {
    name: 'add-school',
    label: 'Cadastrar escola / turma',
    icon: 'mdi-home-plus',
    href: '/school-form',
  },
  {
    name: 'material-request',
    label: 'Solicitar material',
    icon: 'mdi-toy-brick-plus',
    href: '/material-request',
  },
  {
    name: 'food-record',
    label: 'Registro Alimentar',
    icon: 'mdi-food-fork-drink',
    href: '/food-record'
  },
  {
    name: 'settings',
    label: 'Parametrização do Sistema',
    icon: 'mdi-cogs',
    href: '/settings'
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
