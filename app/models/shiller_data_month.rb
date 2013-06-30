class ShillerDataMonth < ActiveRecord::Base
  attr_accessible :cape, :cpi, :date_fraction, :dividends, :earnings, :long_interest_rate, :real_dividends, :real_earnings, :sp_index, :year_month, :real_sp_index_return, :dividend_return, :real_total_return

  def calc_real_sp_index
    self.inflation_adjustment(sp_index)
  end

  def calc_real_earnings
    self.inflation_adjustment(earnings)
  end

  def calc_real_dividends
    self.inflation_adjustment(dividends)
  end

  def inflation_adjustment(number)
    latest_cpi = ShillerDataMonth.last.cpi
    latest_cpi / self.cpi * number
  end

  def price_to_earnings
    self.sp_index / self.earnings
  end

  def current_year
    self.year_month.split(".").first.to_i
  end

  def current_month
    self.year_month.split(".").last.to_i
  end

  def ten_year_average_real_earnings
    d = Date.new(current_year, current_month)
    start_date = Date.new(1871, 1)
    if (d - 120.months) < start_date
      return "insufficient data"
    end
    end_id = self.id
    start_id = end_id - 120 - 1
    ShillerDataMonth.where("id > ? AND id < ?", start_id, end_id).average(:real_earnings).to_f
  end

  def calc_cape
    average_earnings = self.ten_year_average_real_earnings
    if average_earnings == "insufficient data"
      return ""
    end
    self.real_sp_index / average_earnings
  end

  def self.cape_data_array
    result = []
    ShillerDataMonth.where("cape IS NOT NULL").order(:id).each do |sd|
      result << [sd.formatted_time, sd.cape.round(2)]
    end
    result
  end

  def formatted_time
    Time.new(current_year, current_month).to_i * 1000
  end

  def self.interest_rates_data_array
    interest_rates_data = []
    ShillerDataMonth.where("long_interest_rate IS NOT NULL").order(:id).each do |sd|
      interest_rates_data << [sd.formatted_time, sd.long_interest_rate.round(2)]
    end
    interest_rates_data
  end

  def self.dividend_yield_data_array
    dividend_yield_data = []
    ShillerDataMonth.where("dividends IS NOT NULL AND sp_index IS NOT NULL").order(:id).each do |sd|
      dividend_yield_data << [sd.formatted_time, sd.dividend_yield.round(2)]
    end
    dividend_yield_data
  end

  def dividend_yield
    self.dividends / self.sp_index * 100
  end

  def self.sp_data
    sp_data = []
    ShillerDataMonth.where("real_sp_index IS NOT NULL").order(:id).each do |sd|
      sp_data << [sd.formatted_time, sd.real_sp_index.round(2)]
    end
    sp_data
  end

  def convert_year_month_to_date
    year, month = self.year_month.split(".")
    Date.new(year.to_i, month.to_i)
  end

  def convert_date_to_year_month(date)
    "#{date.year}.#{sprintf('%02d', date.month)}"
  end

  def prior_shiller_data_month
    date = self.convert_year_month_to_date
    return nil if date <= Date.new(1871, 1)
    prior_date = date - 1.month
    ShillerDataMonth.find_by_year_month(self.convert_date_to_year_month(prior_date))
  end

  def real_sp_index_return
    return nil if self.prior_shiller_data_month.nil?
    self.real_sp_index / self.prior_shiller_data_month.real_sp_index - 1
  end

  def dividend_return
   self.dividends / 12 / self.sp_index
  end

  def real_total_return
    self.real_sp_index_return + self.dividend_return
  end

end
