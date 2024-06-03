class App {
  isMobile() {
    return window.document.body.clientWidth < 500;
  }
  getPublicRoutes() {
    return ['/', '/login', '/otp', '/forgot-password', '/new-password'];
  }
}

export default new App();
