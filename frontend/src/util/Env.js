class Env {
  get(key) {
    const preffix = 'VITE_';
    return import.meta.env[key.includes(preffix) ? key : `${preffix}${key}`];
  }
}

export default new Env();
