$(function() {
  $('.btn-primary').click(function(){
    if(FinancialCalculators.Retirement.validate_results() != "stop") {
      FinancialCalculators.Retirement.prepend_result_div();
      $('#calculator_instructions').hide();
    }
  });
});
