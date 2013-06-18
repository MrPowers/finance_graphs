class ShillerDataMonthsController < ApplicationController
  def cape_data
    @result = ShillerDataMonth.cape_data_array
    respond_to do |format|
      format.html
    end
  end

  def interest_rates_dividends
    @interest_rates_data = ShillerDataMonth.interest_rates_data_array
    @dividend_yield_data = ShillerDataMonth.dividend_yield_data_array
    respond_to do |format|
      format.html
    end
  end

  def sp_index
    @result = ShillerDataMonth.sp_data
    respond_to do |format|
      format.html
    end
  end
end
