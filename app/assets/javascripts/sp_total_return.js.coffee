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

  draw_table: ->
    balance = 1
    for data_month in @data_months
      balance = balance *= (1 + data_month.real_total_return)
      row = "<tr>
      <td>#{DateHelpers.formatted_date data_month.record_date}</td>
      <td>#{NumberToString.percent_formatting data_month.real_total_return}</td>
      <td>#{NumberToString.round_float(balance, 2)}</td>
      </tr>"
      jQuery('table tbody').append(row)


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
        tr.draw_table()
        console.log "CAGR: #{tr.cagr()}"
        console.log "Total Return: #{tr.total_return()}"
        console.log "Total Months: #{tr.total_months()}"
        #alert tr.cagr()
        console.log data
      error: ->
        alert("failure")
