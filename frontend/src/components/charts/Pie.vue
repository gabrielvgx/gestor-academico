<template>
  <v-chart class='chart' :option='option' @selectchanged="onSelectChanged" />
</template>

<script lang="js">
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { PieChart } from 'echarts/charts';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
} from 'echarts/components';
import VChart from 'vue-echarts';
import { ref } from 'vue';

use([
  CanvasRenderer,
  PieChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
]);

export default {
  components: {
    VChart,
  },
  props: ['options'],
  emits: ['onSelect'],
  methods: {
    onSelectChanged(eventInfo) {
      if (eventInfo.fromActionPayload) {
        this.$emit('onSelect', {
          event: eventInfo,
          data: this.options.data[eventInfo.fromActionPayload.dataIndexInside],
        })
      }
    }
  },
  setup(props) {
    const {
      titleText,
      tooltip,
      legendData,
      data,
      color = ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272', '#fc8452', '#9a60b4', '#ea7ccc'],
    } = props.options;
    const option = ref({
      title: {
        text: titleText,
        left: 'left',
      },
      tooltip: tooltip || {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)',
      },
      legend: {
        orient: 'vertical',
        left: 10,
        top: 30,
        data: legendData || [],
      },
      series: [
        {
          name: 'Planejamentos',
          type: 'pie',
          radius: '60%',
          center: ['50%', '65%'],
          color,
          data: data || [
            { value: 335, name: 'Direct' },
            { value: 310, name: 'Email' },
            { value: 234, name: 'Ad Networks' },
            { value: 135, name: 'Video Ads' },
            { value: 1548, name: 'Search Engines' },
          ],
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)',
            },
          },
        },
      ],
    });
    return { option };
  }
}
</script>

<style langs="scss" scoped>
.chart {
  height: 400px;
}
</style>
