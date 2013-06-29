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
    result_html = "<div class='span5 pull-right text-center hero-unit'>
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


$ = jQuery

$ ->
  $('#future_value_button').click ->
    pv = StringToNumber.convert_to_float $("#current_retirement_money").val()
    cf = StringToNumber.convert_to_float $("#current_salary").val()
    g = StringToNumber.convert_to_percent $("#annual_salary_increases").val()
    savings_rate = StringToNumber.convert_to_percent $("#percent_of_salary_diverted_to_retirement").val()
    i = StringToNumber.convert_to_percent $("#annual_return").val()
    n = StringToNumber.convert_to_float $("#time").val()

    if InputValidator.validate([pv, cf, g, savings_rate, i, n])
      $('#calculator_instructions').hide()
      fv = new FutureValue(pv, cf, g, savings_rate, i, n)
      fv.draw_results()
