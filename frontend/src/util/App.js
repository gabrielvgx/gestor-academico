class App {
  isMobile() {
    return window.document.body.clientWidth < 500;
  }
}

export default new App();
