import Request from "@/util/Request";

class Dashboard {
  getStatusByKey(key) {
    return ({
      NAO_ENTREGUE: {
        label: 'Não Entregue',
        color: '#ee6666',
      },
      ENTREGUE_NO_PRAZO: {
        label: 'Entregue no Prazo',
        color: '#91cc75',
      },
      ENTREGUE_ATRASADO: {
        label: 'Entregue Atrasado',
        color: '#fac858',
      }
    })[key]
  }
  async getPlanningGraphOptions() {
    const { planning } = await Request.get('/dashboard');
    const labels = [];
    const colors = [];
    const data = Object.keys(planning.analytic).map(key => {
      const { label, color } = this.getStatusByKey(key);
      labels.push(label);
      colors.push(color);
      return ({
        key,
        name: label,
        value: planning.analytic[key],
        color,
      })
    });
    return {
      titleText: 'Entrega de Planejamento',
      legendData: labels,
      color: colors,
      data,
      chartName: 'planning-graph',
    }
  }
}

export default new Dashboard();
