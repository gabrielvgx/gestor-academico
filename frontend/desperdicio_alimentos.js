window.addEventListener('load', function() {
  const echartsGraph = document.getElementById('echarts-graph');
  const myChart = echarts.init(echartsGraph);

  const option = {
    title: {
        text: 'Histórico de Desperdício',
        left: 'center',
        top: '5%',
      },
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }
      },
      legend: {
        data: ['Desperdício de Comida (kg)'],
        left: 'center',
        top: '15%'
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      toolbox: {
        show: true,
        feature: {
          dataView: { show: true, readOnly: false },
          magicType: { show: true, type: ['line', 'bar'] },
          restore: { show: true },
          saveAsImage: { show: true }
        }
      },
      xAxis: {
        type: 'category',
        data: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
      },
      yAxis: [
        {
          type: 'value',
          name: '        Desperdício de Comida (kg)',
          axisLabel: {
            formatter: '{value} kg'
          }
        }
      ],
      series: [
        {
          name: 'Desperdício de Comida (kg)',
          type: 'bar',
          data: [
            2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3
          ],
          yAxisIndex: 0,
          itemStyle: {
            color: 'red'
          }
        }
      ]
    };

  myChart.setOption(option);

  window.addEventListener('resize', function() {
    myChart.resize();
  });
});
