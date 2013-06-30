$ = jQuery

$ ->
  cape_chart_page = $("#cape_chart_page")
  dividend_yield_interest_page = $("#dividend_yield_interest_page")
  sp_index_page = $("#sp_index_page")
  divs = [cape_chart_page, dividend_yield_interest_page, sp_index_page]
  current_page_div = ""
  for div in divs
    current_page_div = div.attr('id') if div.length > 0

  switch current_page_div
    when "cape_chart_page"
      data = [{
        name: "CAPE"
        data: $('#cape_data').data('result')
      }]
      settings = { "div_id":"#cape_chart", "chart_title":"CAPE of the S&P 500 Index", "data":data }
      HighStockLineGraph.create_chart(settings)

    when "dividend_yield_interest_page"
      interest_rates_data = $('#interest_rates_data').data('interest-rates-data')
      dividend_yield_data = $('#dividend_yield_data').data('dividend-yield-data')
      data =
        [{
          name : "Long Term Interest Rates"
          data : interest_rates_data
        },{
          name : "Dividend Yields"
          data : dividend_yield_data
        }]
      settings = { "div_id":"#dividend_yield_interest_chart", "chart_title":"U.S. Interest Rates and Dividend Yields", "data":data }
      HighStockLineGraph.create_chart(settings)

    when "sp_index_page"
      sp_data = $('#sp_data').data('sp-data')
      sp_data = [{
        name : "S&P 500 Index"
        data : sp_data
      }]

      linear_settings = { "div_id":"#sp_chart", "chart_title":"Real S&P 500 Index", "data":sp_data }
      HighStockLineGraph.create_chart(linear_settings)

      log_settings = { "div_id":"#sp_index_log_scale", "chart_title":"Real S&P 500 Index Log Scale", "data":sp_data, 'vertical_scale':'logarithmic' }
      HighStockLineGraph.create_chart(log_settings)
