$(function() {
  $('.btn-primary').click(function(){
    var present_value = $("#current_retirement_money").val();
    present_value = FinancialCalculators.Retirement.convert_to_number(present_value);

    var current_salary = $("#current_salary").val();
    current_salary = FinancialCalculators.Retirement.convert_to_number(current_salary);

    var annual_salary_increases = $("#annual_salary_increases").val();
    annual_salary_increases = FinancialCalculators.Retirement.convert_to_percent(annual_salary_increases);

    var percent_of_salary_saved = $("#percent_of_salary_diverted_to_retirement").val();
    percent_of_salary_saved = FinancialCalculators.Retirement.convert_to_percent(percent_of_salary_saved);

    var annual_return = $("#annual_return").val();
    annual_return = FinancialCalculators.Retirement.convert_to_percent(annual_return);

    var time = $("#time").val();
    time = FinancialCalculators.Retirement.convert_to_number(time);

    var result = FinancialCalculators.Retirement.continuously_compounded_future_value(present_value, current_salary, percent_of_salary_saved, time, annual_return, annual_salary_increases);
    alert(FinancialCalculators.Retirement.numberWithCommas(result));
  });
});
