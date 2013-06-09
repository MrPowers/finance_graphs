var FinancialCalculators = {

  Retirement : {

    convert_to_number : function(string) {
      string = string.replace( /[,$ ]/g, "" );
      number = parseFloat(string);
      return number;
    },

    convert_to_percent : function(string) {
      string = string.replace( /[,%]/g, "" );
      number = parseFloat(string);
      if (number > 1) {
        number = number / 100;
      };
      return number;
    },

    numberWithCommas : function(x) {
      return Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },

    // pv = present value
    // cf = cash flow
    // g = cash flow growth (annual salary increases)
    // n = number of years
    // i = interest rate
    // savings_rate = percentage of salary that is saved
    continuously_compounded_future_value : function(pv, cf, savings_rate, n, i, g) {
      var answer = pv * Math.exp(i * n) +
        (cf * savings_rate) * Math.exp(i * n) / (i - g) *
        (1 - Math.exp(-(i - g) * n));
      return answer
    },

    calculate_fv : function() {
      var pv = $("#current_retirement_money").val();
      pv = this.convert_to_number(pv);

      var cf = $("#current_salary").val();
      cf = this.convert_to_number(cf);

      var g = $("#annual_salary_increases").val();
      g = this.convert_to_percent(g);

      var savings_rate = $("#percent_of_salary_diverted_to_retirement").val();
      savings_rate = this.convert_to_percent(savings_rate);

      var i = $("#annual_return").val();
      i = this.convert_to_percent(i);

      var n = $("#time").val();
      n = this.convert_to_number(n);

      var fv = this.continuously_compounded_future_value(pv, cf, savings_rate, n, i, g);
      return {
        pv : pv,
        cf : cf,
        g : g,
        savings_rate :savings_rate,
        i : i,
        n : n,
        fv : fv
      };
    },

    prepend_result_div : function() {
      var results = this.calculate_fv();
      fv = this.numberWithCommas(results.fv);
      var result_html = "<div class='span5 pull-right text-center hero-unit'>" +
        "<h3>Future Value of Retirement Portfolio:</h3>" +
        "<h2>" + results.fv + "</h2>" +
        "<ul class='unstyled'>" +
          "<li><span class='label label-info'>Assumptions</span></li>" +
          "<li>Present Value:" + results.pv + "</li>" +
          "<li>Salary:" + results.cf + "</li>" +
          "<li>Salary Increases:" + results.g + "</li>" +
          "<li>Percent of Salary Saved:" + results.savings_rate + "</li>" +
          "<li>Investment Return:" + results.i + "</li>" +
          "<li>Number of Years Until Retirement:" + results.n + "</li>" +
        "</ul>" +
      "</div>"
      $('#result_summary').prepend(result_html);
    }

  }

}
