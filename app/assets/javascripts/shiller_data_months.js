$(function() {
  $('#container').highcharts('StockChart', {
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
      text : 'CAPE History of S&P 500 Index'
    },

    xAxis: {
      type: 'datetime',
      dateTimeLabelFormats: {
        second: '%b %Y',
        minute: '%b %Y',
        hour: '%b %Y',
        day: '%b %Y',
        week: '%b %Y',
        month: '%Y',
        year: '%Y'
      }
    },

    series : [{
      name : 'CAPE',
      data : $('#cape_data').data('result'),
      tooltip: {
        valueDecimals: 2,
      },
      dataGrouping: {
        //enabled : false
        forced : true,
        smoothed: true,
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
    }]//end series
  });//end highcharts
});
