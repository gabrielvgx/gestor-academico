import MenuConfig from "@/MenuConfig";
import Env from "./Env";
import Token from "./Token";

class AccessControl {

  isEnabled() {
    return Env.get('USE_ACCESS_CONTROL') === 'YES';
  }
  getMenu() {
    const menu = MenuConfig.getAll();
    const userProfile = Token.getUserProfile();
    if (this.isEnabled()) {
      if (!userProfile && localStorage.getItem('token')) {
        localStorage.clear();
        window.location.reload();
      }
      const filteredMenu = menu.filter(menuItem => {
        if (Array.isArray(menuItem.permissions) && menuItem.permissions.length) {
          return menuItem.permissions.includes(userProfile);
        }
        return true;
      });
      return filteredMenu;
    }
    return menu;
  }
}

export default new AccessControl();
