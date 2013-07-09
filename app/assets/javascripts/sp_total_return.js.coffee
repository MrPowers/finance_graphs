class TotalReturn
  constructor: (data_months) ->
    @data_months = data_months

  total_return: ->
    result = 1
    for data_month in @data_months
      result *= (1 + data_month.real_total_return)
    result - 1

  cagr: ->
    fv = this.total_return()
    n = this.investment_years()
    Math.pow((1 + fv), (1 / n)) - 1

  start_date: ->
    @data_months[0].record_date

  end_date: ->
    @data_months[@data_months.length - 1].record_date

  investment_years: ->
    DateHelpers.years_between_dates(this.start_date(), this.end_date())

  total_months: ->
    @data_months.length

  data_highstock: ->
    result = []
    balance = 1
    for data_month in @data_months
      balance = balance *= (1 + data_month.real_total_return)
      result.push([DateHelpers.record_date_to_milliseconds(data_month.record_date), balance])
    [{
      name : "Total Return"
      data : result
    }]

  draw_results: ->
    result = "<h3>Results from #{DateHelpers.formatted_date this.start_date()} to #{DateHelpers.formatted_date this.end_date()}</h3>
      <ul class='unstyled'>
        <li>CAGR: #{NumberToString.percent_formatting this.cagr()}</li>
        <li>Total Return: #{NumberToString.percent_formatting this.total_return()}</li>
        <li>Investment Years: #{NumberToString.round_float this.investment_years(), 1}</li>
      </ul>"
    $('#result_summary').prepend(result)


$ = jQuery

$ ->
  $('#return_calculator_button').click ->
    start_year = $('#start_year').val()
    start_month = $('#start_month').val()
    end_year = $('#end_year').val()
    end_month = $('#end_month').val()

    $.ajax
      url: "/historic_returns"
      #contentType: "application/json"
      type: "GET"
      data:
        start_year: start_year
        start_month: start_month
        end_year: end_year
        end_month: end_month
      dataType: "json"
      success: (data) ->
        tr = new TotalReturn(data)
        $('#result_summary').empty()
        tr.draw_results()
        data_highstock = tr.data_highstock()
        settings = { "div_id":"#historic_returns_chart", "chart_title":"Total Return Over Time Interval", "data":data_highstock }
        HighStockLineGraph.create_chart(settings)
      error: ->
        alert("failure")
