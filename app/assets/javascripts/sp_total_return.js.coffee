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

  investment_years: ->
    start_date = @data_months[0].record_date
    end_date = @data_months[@data_months.length - 1].record_date
    DateHelpers.years_between_dates(start_date, end_date)

  total_months: ->
    @data_months.length

  #draw_table: ->
    #balance = 1
    #for data_month in @data_months
      #balance = balance *= (1 + data_month.real_total_return)
      #row = "<tr>
      #<td>#{DateHelpers.formatted_date data_month.record_date}</td>
      #<td>#{NumberToString.percent_formatting data_month.real_total_return}</td>
      #<td>#{NumberToString.round_float(balance, 2)}</td>
      #</tr>"
      #jQuery('table tbody').append(row)

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
    result_html = "<div class='span5 text-center hero-unit'>
      <h3>Total return over selected time period</h3>
      <h3>CAGR: #{this.cagr()}</h3>
    </div>"
    $('#result_summary').prepend(result_html)



class DateHelpers
  # converts "YYYY-MM-DD" to JS Date object
  this.string_to_date = (string) ->
    [year, month, day] = string.split("-")
    new Date(parseInt(year), parseInt(month), parseInt(day))

  this.milliseconds_in_year = ->
    1000 * 60 * 60 * 24 * 365.25

  # input dates are in "YYYY-MM-DD format"
  this.years_between_dates = (start_date, end_date) ->
    start_date = this.string_to_date(start_date)
    end_date = this.string_to_date(end_date)
    (end_date - start_date) / this.milliseconds_in_year()

  this.month_names = ->
    ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

  # input date is in "YYYY-MM-DD format"
  this.formatted_date = (string) ->
    month_names = this.month_names()
    [year, month, day] = string.split("-")
    month_index = parseInt(month) - 1
    "#{month_names[month_index]} #{year}"

  # input date is in "YYYY-MM-DD format"
  this.record_date_to_milliseconds = (string) ->
    new Date(string).getTime()



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
        $('#calculator_instructions').hide()
        tr.draw_results()
        data_highstock = tr.data_highstock()
        settings = { "div_id":"#historic_returns_chart", "chart_title":"Total Return Over Time Interval", "data":data_highstock }
        HighStockLineGraph.create_chart(settings)
        #console.log "CAGR: #{tr.cagr()}"
        #console.log "Total Return: #{tr.total_return()}"
        #console.log "Total Months: #{tr.total_months()}"
        ##alert tr.cagr()
        #console.log data
        #console.log data_array
      error: ->
        alert("failure")
