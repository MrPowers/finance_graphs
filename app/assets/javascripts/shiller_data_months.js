var ShillerDataMonth = {
  //settings = { "div_id":"#container", "chart_title":"S&P 500 Index", "data":[specific_format], 'vertical_scale':'logarithmic[optional]' }
  create_chart : function(settings) {
    $(settings['div_id']).highcharts('StockChart', {
      rangeSelector : {
        buttons: [{
          type: 'year',
          count: 1,
          text: '1y'
        }, {
          type: 'all',
          text: 'All'
        }]
      },

      title : {
        text : settings['chart_title']
      },

      yAxis : {
        type: settings['vertical_scale']
      },

      xAxis: {
        type: 'datetime',
        dateTimeLabelFormats: {
          second: '%b %Y',
          minute: '%b %Y',
          hour: '%b %Y',
          day: '%b %Y',
          week: '%b %Y',
          month: '%b %Y',
          year: '%Y'
        }
      },

      plotOptions: {
        series: {
          dataGrouping: {
            //enabled : false
            forced : true,
            //smoothed: true,
            dateTimeLabelFormats: {
              millisecond: ['%B %Y', '', '%B %Y'],
              second: ['%B %Y', '', '%B %Y'],
              minute: ['%B %Y', '', '%B %Y'],
              hour: ['%B %Y', '', '%B %Y'],
              day: ['%B %Y', '', '%B %Y'],
              week: ['%B %Y', '', '%B %Y'],
              month: ['%B %Y', '', '%B %Y'],
              year: ['%Y', '%Y', '-%Y']
            }
          }
        }
      },

      series : settings['data'],

      tooltip: {
        valueDecimals: 2,
      }

    });

  }
}
