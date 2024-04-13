class Dashboard {
  getPlanningGraphOptions() {
    return {
      titleText: 'Entrega de Planejamento',
      legendData: ['Entregue no Prazo', 'Entregue Atrasado', 'Não Entregue'],
      color: ['#91cc75', '#fac858', '#ee6666'],
      data: [
        { value: 7, name: 'Entregue no Prazo' },
        { value: 5, name: 'Entregue Atrasado' },
        { value: 3, name: 'Não Entregue' },
      ],
    }
  }
}

export default new Dashboard();
