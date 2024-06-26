<template>
  <v-container class="pa-0 my-0">
    <v-chart :id="chartName" class='chart' :option='option' />
  </v-container>
</template>

<script lang="js">
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart, LineChart } from 'echarts/charts';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
  ToolboxComponent,
  MarkLineComponent,
  MarkPointComponent,
} from 'echarts/components';
import VChart from 'vue-echarts';
import { ref } from 'vue';
import * as echarts from 'echarts/core';
import { onUnmounted } from 'vue';

use([
  LineChart,
  MarkPointComponent,
  MarkLineComponent,
  CanvasRenderer,
  BarChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
  ToolboxComponent,
]);

export default {
  components: {
    VChart,
  },
  props: ['options'],
  setup(props) {
    const {
      titleText,
      subTitleText,
      tooltip,
      chartName,
      series,
      labels,
      // legendData,
      // data,
      // legendDataX,
      // color = ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272', '#fc8452', '#9a60b4', '#ea7ccc'],
    } = props.options;
    console.log(props.options);
    const defaultSerieProps = {
      type: 'bar',
      data: [],
      markPoint: {
        data: [
          { type: 'max', name: 'Max' },
          { type: 'min', name: 'Min' }
        ]
      },
      markLine: {
        data: [{ type: 'average', name: 'Avg' }]
      }
    };
    const seriesHandled = series.map(serie => {
      return {...defaultSerieProps, ...serie};
    })
    const handleResize = () => {
      const el = document.getElementById(chartName);
      const graphEl = el && el.children ? el.children[0] : null
      const chartInstance = graphEl ? echarts.getInstanceByDom(graphEl) : null;
      if (chartInstance) {
        chartInstance.resize();
      }
    };
    window.addEventListener('resize', handleResize);
    onUnmounted(() => {
      window.removeEventListener('resize', handleResize);
    });
    const option = ref({
      title: {
        text: titleText || 'Análise de Desperdício Alimentar (KG)',
        subtext: subTitleText || 'Últimos 6 meses'
      },
      tooltip: tooltip || {
        trigger: 'axis',
      },
      legend: {
        top: 70,
        data: seriesHandled.map(serie => serie.name)
      },
      toolbox: {
        top: 30,
        show: true,
        feature: {
          dataView: { show: true, readOnly: false },
          magicType: { show: true, type: ['line', 'bar'] },
          restore: { show: true },
          saveAsImage: { show: true }
        }
      },
      grid: {
        top: 120
      },
      calculable: true,
      xAxis: [
        {
          type: 'category',
          data: labels || ['Jan', 'Fev', 'Mar', 'Abr', 'Maio', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
        }
      ],
      yAxis: [
        {
          type: 'value'
        }
      ],
      series: seriesHandled || [
        {
          name: 'Sobra limpa',
          type: 'bar',
          data: [
            2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3
          ],
          markPoint: {
            data: [
              { type: 'max', name: 'Max' },
              { type: 'min', name: 'Min' }
            ]
          },
          markLine: {
            data: [{ type: 'average', name: 'Avg' }]
          }
        },
        {
          name: 'Sobra suja',
          type: 'bar',
          data: [
            2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3
          ],
          markPoint: {
            data: [
              { type: 'max', name: 'Max' },
              { type: 'min', name: 'Min' }
            ]
          },
          markLine: {
            data: [{ type: 'average', name: 'Avg' }]
          }
        }
      ],
    });
    return { option, chartName };
  }
}
</script>
<style lang="scss" scoped>
.chart {
  height: 500px;
}
</style>
