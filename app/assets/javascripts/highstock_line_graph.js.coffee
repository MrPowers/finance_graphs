window.HighStockLineGraph = create_chart: (settings) ->
  $(settings["div_id"]).highcharts "StockChart",
    rangeSelector:
      buttons: [
        type: "year"
        count: 10
        text: "10y"
      ,
        type: "year"
        count: 20
        text: "20y"
      ,
        type: "year"
        count: 30
        text: "30y"
      ,
        type: "all"
        text: "All"
       ]

    title:
      text: settings["chart_title"]

    yAxis:
      type: settings["vertical_scale"]

    xAxis:
      type: "datetime"
      dateTimeLabelFormats:
        second: "%b %Y"
        minute: "%b %Y"
        hour: "%b %Y"
        day: "%b %Y"
        week: "%b %Y"
        month: "%b %Y"
        year: "%Y"

    plotOptions:
      series:
        dataGrouping:
          forced: true
          dateTimeLabelFormats:
            millisecond: [ "%B %Y", "", "%B %Y" ]
            second: [ "%B %Y", "", "%B %Y" ]
            minute: [ "%B %Y", "", "%B %Y" ]
            hour: [ "%B %Y", "", "%B %Y" ]
            day: [ "%B %Y", "", "%B %Y" ]
            week: [ "%B %Y", "", "%B %Y" ]
            month: [ "%B %Y", "", "%B %Y" ]
            year: [ "%Y", "%Y", "-%Y" ]

    series: settings["data"]

    tooltip:
      valueDecimals: 2
