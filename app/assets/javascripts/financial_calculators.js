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

    future_value : function(present_value, interest_rate, time) {
      result = present_value * Math.exp(interest_rate * time);
      return result;
    },

    first_formula_component : function(salary, salary_savings_rate, time, interest_rate, salary_growth_rate) {
      return (salary * salary_savings_rate) * Math.exp(interest_rate * time) / (interest_rate - salary_growth_rate)
    },

    second_formula_component: function(interest_rate, salary_growth_rate, time) {
      return (1 - Math.exp(-(interest_rate - salary_growth_rate) * time));
    },

    continuously_compounded_future_value : function(present_value, salary, salary_savings_rate, time, interest_rate, salary_growth_rate) {
      return((this.future_value(present_value, interest_rate, time) + this.first_formula_component(salary, salary_savings_rate, time, interest_rate, salary_growth_rate) * this.second_formula_component(interest_rate, salary_growth_rate, time)));
      //console.log(this.future_value(present_value, interest_rate, time));
      //console.log(this.first_formula_component(salary, salary_savings_rate, time, interest_rate, salary_growth_rate));
      //console.log(this.second_formula_component(interest_rate, salary_growth_rate, time));
    }

  }

}
