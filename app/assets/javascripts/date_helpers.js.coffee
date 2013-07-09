class window.DateHelpers
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
