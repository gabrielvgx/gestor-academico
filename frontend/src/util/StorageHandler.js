class StorageHandler {
  setForgotPassUser(user) {
    localStorage.setItem('forgot-password-user', user);
  }
  getForgotPassUser() {
    return localStorage.getItem('forgot-password-user');
  }
  setNewPassToken(token) {
    localStorage.setItem('new-pass-token', token);
  }
  getNewPassToken() {
    return localStorage.getItem('new-pass-token');
  }
  getFilter(screenName) {
    try {
      const filter = localStorage.getItem(`filter-${screenName}`);
      if (filter) {
        return JSON.parse(filter);
      }
    } catch(err) {
      console.error(err.message);
      return null;
    }
  }
  setFilter(screenName, filter) {
    try {
      localStorage.setItem(`filter-${screenName}`, JSON.stringify(filter));
    } catch(err) {
      console.error(err.message);
    }
  }
}

export default new StorageHandler();
