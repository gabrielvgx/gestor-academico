import Request from "@/util/Request";

class Notification {
  handleNotification(key, value) {
    switch(key) {
      case 'PENDING_PLANNING':
        return {
          title: 'Solicitação - Planejamento',
          description: `${Number(value)} planejamento(s) pendente(s) de análise`,
          type: Number(value) === 0 ? 'success' : 'warn',
        }
      case 'PENDING_MATERIAL_REQUEST':
        return {
          title: 'Solicitação - Material',
          description: `${Number(value)} material(ais) solicitado(s), pendente de análise`,
          type: Number(value) === 0 ? 'success' : 'warn',
        }
    }
  }

  async load() {
    try {
      const { data } = await Request.get('/notification');
      return Object.keys(data).map(key => {
        return this.handleNotification(key, data[key]);
      });
    } catch (err) {
      console.error(err.message);
    }
  }
}
new Notification().load();
export default new Notification();
