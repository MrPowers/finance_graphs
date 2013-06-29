class FutureValue
  constructor: (pv, cf, g, savings_rate, i, n) ->
    @pv = pv
    @cf = cf
    @g = g
    @savings_rate = savings_rate
    @i = i
    @n = n
    @fv = this.continuously_compounded_future_value()

  continuously_compounded_future_value: ->
    @pv * Math.exp(@i * @n) + (@cf * @savings_rate) * Math.exp(@i * @n) / (@i - @g) * (1 - Math.exp(-(@i - @g) * @n))

  draw_results: ->
    result_html = "<div class='span5 text-center hero-unit'>
      <h3>Future Value of Retirement Portfolio:</h3>
      <h2>$#{NumberToString.number_with_commas @fv}</h2>
      <ul class='unstyled'>
        <li><span class='label label-info'>Assumptions</span></li>
        <li>Present Value: #{NumberToString.number_with_commas @pv}</li>
        <li>Salary: #{NumberToString.number_with_commas @cf}</li>
        <li>Salary Increases: #{NumberToString.percent_formatting @g}</li>
        <li>Percent of Salary Saved: #{NumberToString.percent_formatting @savings_rate}</li>
        <li>Investment Return: #{NumberToString.percent_formatting @i}</li>
        <li>Number of Years Until Retirement: #{NumberToString.number_with_commas @n}</li>
      </ul>
    </div>"
    $('#result_summary').prepend(result_html)

  investment_growth: ->
    result = []
    starting_value = @pv
    salary = @cf
    for year in [1..@n]
      investment_return = starting_value * @i
      savings = salary * @savings_rate
      ending_value = starting_value + investment_return + savings
      result.push({ year: year, starting_value: starting_value, salary: salary, savings: savings, investment_return: investment_return, ending_value: ending_value })
      salary = salary * (1 + @g)
      starting_value = ending_value
    result

  draw_table: ->
    data = this.investment_growth()
    for year_data in data
      row = "<tr>
      <td>#{NumberToString.number_with_commas year_data.year}</td>
      <td>#{NumberToString.number_with_commas year_data.starting_value}</td>
      <td>#{NumberToString.number_with_commas year_data.investment_return}</td>
      <td>#{NumberToString.number_with_commas year_data.salary}</td>
      <td>#{NumberToString.number_with_commas year_data.savings}</td>
      <td>#{NumberToString.number_with_commas year_data.ending_value}</td>
      </tr>"
      jQuery('#future_value_table tbody').append(row)


$ = jQuery

$ ->
  $('#future_value_table').hide()
  $('#future_value_button').click ->
    pv = StringToNumber.convert_to_float $("#current_retirement_money").val()
    cf = StringToNumber.convert_to_float $("#current_salary").val()
    g = StringToNumber.convert_to_percent $("#annual_salary_increases").val()
    savings_rate = StringToNumber.convert_to_percent $("#percent_of_salary_diverted_to_retirement").val()
    i = StringToNumber.convert_to_percent $("#annual_return").val()
    n = StringToNumber.convert_to_float $("#time").val()

    if InputValidator.validate([pv, cf, g, savings_rate, i, n])
      $('#future_value_table').fadeIn()
      $('#future_value_table tbody tr').remove()
      $('#calculator_instructions').hide()
      fv = new FutureValue(pv, cf, g, savings_rate, i, n)
      fv.draw_results()
      fv.draw_table()
