var interest_rates_data = $('#interest_rates_data').data('interest_rates_data')
var dividend_yield_data = $('#dividend_yield_data').data('dividend_yield_data')
var data_series =
  [{
    name : "Long Term Interest Rates",
    data : interest_rates_data
  },{
    name : "Dividend Yields",
    data : dividend_yield_data
  }]

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
      text : 'Long Term Interest Rates and Dividend Yields'
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

    series : data_series,

    tooltip: {
      valueDecimals: 2,
    }

  });
});
