
class Menu {

  isActiveMenu(menu) {
    const hasSubMenu = Array.isArray(menu.submenu) && menu.submenu.length;
    const { pathname } = window.location;
    const hasActiveSubMenu = hasSubMenu && menu.submenu.find((submenu) => submenu.href === pathname);
    const isActiveMenu = (menu.href === pathname) || !!hasActiveSubMenu || !!(pathname === '/' && menu.isMainPage);
    return isActiveMenu;
  }

  setDefaultIsActive(menuItems) {
    menuItems.forEach((menu) => {
      menu.isActive = this.isActiveMenu(menu);
    });
  }

  hasEnabledAccessControl() {
    return process.env.VUE_APP_ENABLED_ACCESS_PROFILE === 'YES';
  }

  isEnabledMenu(menu, userPermission) {
    if (!Array.isArray(menu.permissions) || !menu.permissions.length) {
      return true;
    }
    return menu.permissions.every((permission) => userPermission[permission] === 'S');
  }

  hasSubMenu(menu) {
    return Array.isArray(menu.submenu) && menu.submenu.length;
  }

  getUserPermissions() {
    const permissionsEncoded = localStorage.getItem('PERMISSIONS');
    let permissionsDecoded = {};
    if (permissionsEncoded) {
      permissionsDecoded = JSON.parse(atob(permissionsEncoded));
    }
    return permissionsDecoded;
  }

}

export default new Menu();
