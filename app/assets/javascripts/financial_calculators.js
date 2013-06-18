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

    formatDecimal : function(x) {
      var result = parseFloat(x * 100).toFixed(1);
      return(result + "%");
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

    form_values : function() {
      var pv = $("#current_retirement_money").val();
      var cf = $("#current_salary").val();
      var g = $("#annual_salary_increases").val();
      var savings_rate = $("#percent_of_salary_diverted_to_retirement").val();
      var i = $("#annual_return").val();
      var n = $("#time").val();
      return {
        pv : pv,
        cf : cf,
        g : g,
        savings_rate :savings_rate,
        i : i,
        n : n
      };
    },

    format_results : function() {
      var results = this.form_values();
      var pv = this.convert_to_number(results.pv);
      var cf = this.convert_to_number(results.cf);
      var g = this.convert_to_percent(results.g);
      var savings_rate = this.convert_to_percent(results.savings_rate);
      var i = this.convert_to_percent(results.i);
      var n = this.convert_to_number(results.n);
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

    validate_results : function(results) {
      var results = this.form_values();
      var emptyFields;
      $.each( results, function( key, value ) {
        if(!value) {
          emptyFields = true;
        };
      });
      if(emptyFields) {
        alert("All fields must be filled in to calculated the future value");
        return "stop";
      };
    },

    prepend_result_div : function() {
      var results = this.format_results();
      var fv = this.numberWithCommas(results.fv);
      var pv = this.numberWithCommas(results.pv);
      var cf = this.numberWithCommas(results.cf);
      var g = this.formatDecimal(results.g);
      var savings_rate = this.formatDecimal(results.savings_rate);
      var i = this.formatDecimal(results.i);
      var n = this.numberWithCommas(results.n);
      var result_html = "<div class='span5 pull-right text-center hero-unit'>" +
        "<h3>Future Value of Retirement Portfolio:</h3>" +
        "<h2>$" + fv + "</h2>" +
        "<ul class='unstyled'>" +
          "<li><span class='label label-info'>Assumptions</span></li>" +
          "<li>Present Value: " + pv + "</li>" +
          "<li>Salary: " + cf + "</li>" +
          "<li>Salary Increases: " + g + "</li>" +
          "<li>Percent of Salary Saved: " + savings_rate + "</li>" +
          "<li>Investment Return: " + i + "</li>" +
          "<li>Number of Years Until Retirement: " + n + "</li>" +
        "</ul>" +
      "</div>"
      $('#result_summary').prepend(result_html);
    }

  }

}
