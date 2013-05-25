class ShillerDataMonth < ActiveRecord::Base
  attr_accessible :cape, :cpi, :date_fraction, :dividends, :earnings, :long_interest_rate, :real_dividends, :real_earnings, :real_price, :sp_index, :year_month

  def real_sp_index
    latest_cpi = ShillerDataMonth.last.cpi
    latest_cpi / self.cpi * self.sp_index
  end
end
