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
}

export default new StorageHandler();
