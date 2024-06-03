import Request from "@/util/Request";
import DateHandler from '@/util/DateHandler';

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
  async getPlanningGraphOptions(schoolId, period) {
    const [ start, end ] = period;
    const startDate = DateHandler.formatDate(start, { to: 'yyyy-MM-dd' });
    const endDate = DateHandler.formatDate(end, { to: 'yyyy-MM-dd' });
    const { planning } = await Request.get('/dashboard', { schoolId, startDate, endDate });
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

  async getFoodGraphOptions(schoolId) {
    const { food } = await Request.get('/dashboard-food', { schoolId });
    const data = {
      labels: [],
      sobralimpa: [],
      sobrasuja: [],
      restoingesta: [],
    }
    food.forEach(row => {
      data.labels.push(DateHandler.formatStrLocale(row.MES_ANO, { from: 'MM/yyyy', to: 'MMM/yy' }));
      data.sobralimpa.push(row.SOBRALIMPA);
      data.sobrasuja.push(row.SOBRASUJA);
      data.restoingesta.push(row.RESTOINGESTA);
    });
    return {
      chartName: 'food-graph',
      labels: data.labels,
      series: [
        {
          name: 'Sobra Limpa',
          data: data.sobralimpa,
        },
        {
          name: 'Sobra Suja',
          data: data.sobrasuja,
        },
      ]
    }
  }
}

new Dashboard().getFoodGraphOptions();
export default new Dashboard();
