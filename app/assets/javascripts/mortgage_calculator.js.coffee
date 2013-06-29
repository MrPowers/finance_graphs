class MortgageCalculator
  constructor: (loan, interest_rate, term) ->
    @loan = loan
    @r = interest_rate / 12 # monthly interest rate
    @n = term * 12 # term in months

  calculate_payment: ->
    numerator = @loan * @r * Math.pow((1 + @r), @n)
    denominator = Math.pow((1 + @r), @n) - 1
    numerator / denominator

  amortization_schedule: ->
    pmt = this.calculate_payment()
    result = []
    beginning_balance = @loan
    for month in [1..@n]
      interest = beginning_balance * @r
      principal = pmt - interest
      ending_balance = beginning_balance - principal
      result.push({ beginning_balance: beginning_balance, interest: interest, principal: principal, ending_balance: ending_balance })
      beginning_balance -= principal
    result

  draw_table: ->
    data = this.amortization_schedule()
    result = ""
    for month_data in data
      result += "<tr>
      <td>#{month_data.month}</td>
      <td>#{month_data.interest}</td>
      <td>#{month_data.principal}</td>
      <td>#{month_data.ending_balance}</td>
      </tr>"
    result

mc = new MortgageCalculator(165000, 0.0425, 2)
console.log mc.draw_table()
