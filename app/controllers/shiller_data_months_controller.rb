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

  def historic_returns
    respond_to do |format|
      format.json do
        start_date = Date.new(params[:start_year].to_i, params[:start_month].to_i)
        end_date = Date.new(params[:end_year].to_i, params[:end_month].to_i)
        @result = ShillerDataMonth.records_between_two_dates(start_date, end_date)
        render :json => @result
      end
    end
  end
end

#curl -H 'Content-type: application/json' -H 'Accept: application/json' -d '{"start_year":"2008","start_month":"1","end_year":"2008","end_month":"12"}' 'http://localhost:3000/historic_returns.json'
