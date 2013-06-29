class MortgageCalculator
  constructor: (loan, interest_rate, term) ->
    @loan = loan
    @r = interest_rate / 12 # monthly interest rate
    @n = term * 12 # term in months
    @pmt = this.calculate_payment()

  calculate_payment: ->
    numerator = @loan * @r * Math.pow((1 + @r), @n)
    denominator = Math.pow((1 + @r), @n) - 1
    numerator / denominator

  total_interest: ->
    @pmt * @n - @loan

  amortization_schedule: ->
    result = []
    beginning_balance = @loan
    for month in [1..@n]
      interest = beginning_balance * @r
      principal = @pmt - interest
      ending_balance = beginning_balance - principal
      result.push({ month: month, beginning_balance: beginning_balance, interest: interest, principal: principal, ending_balance: ending_balance })
      beginning_balance -= principal
    result

  draw_table: ->
    data = this.amortization_schedule()
    for month_data in data
      row = "<tr>
      <td>#{NumberToString.number_with_commas month_data.month}</td>
      <td>#{NumberToString.number_with_commas month_data.interest}</td>
      <td>#{NumberToString.number_with_commas month_data.principal}</td>
      <td>#{NumberToString.number_with_commas month_data.ending_balance}</td>
      </tr>"
      jQuery('table tbody').append(row)

  draw_summary: ->
    $('#mortgage_calculator_summary').empty()
    result = "<p><span class='label label-important'>Summary:</span></p>
    <h3>Monthly Payment: #{NumberToString.number_with_commas @pmt}</h3>
    <h3>Total Interest: #{NumberToString.number_with_commas this.total_interest()}</h3>"
    $('#mortgage_calculator_summary').append(result)



class NumberToString
  this.number_with_commas = (number) ->
    Math.round(number).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

  this.decimal_number_to_percent_string = (x) ->
    result = parseFloat(x * 100).toFixed(1)
    return(result + "%")


class StringToNumber
  this.convert_to_float = (string) ->
    string = string.replace( /[,$ ]/g, "" )
    parseFloat(string)

  this.convert_to_percent = (string) ->
    string = string.replace( /[,%]/g, "" )
    number = parseFloat(string)
    if number > 1
      number = number / 100
    number


class InputValidator
  this.validate = (inputs) ->
    for input in inputs
      if isNaN(input)
        alert("All fields must be filled in to calculated the mortgage amortization schedule")
        return


$ = jQuery

$ ->
  $('table').hide()
  $("#mortgage_button").click ->
    $('table').fadeIn()
    $('tbody tr').remove()

    term = StringToNumber.convert_to_float $("#term").val()
    rate = StringToNumber.convert_to_percent $("#rate").val()
    loan = StringToNumber.convert_to_float $("#loan").val()

    InputValidator.validate([term, rate, loan])

    mc = new MortgageCalculator(loan, rate, term)
    mc.draw_table()
    mc.draw_summary()
