class ShillerDataMonth < ActiveRecord::Base
  attr_accessible :cape, :cpi, :date_fraction, :dividends, :earnings, :long_interest_rate, :real_dividends, :real_earnings, :sp_index, :year_month, :real_sp_index_return, :dividend_return, :real_total_return

  def self.cape_data_array
    result = []
    ShillerDataMonth.where("cape IS NOT NULL").order("record_date asc").each do |sd|
      result << [YearMonth.new(sd.year_month).to_milliseconds, sd.cape.round(2)]
    end
    result
  end

  def self.interest_rates_data_array
    interest_rates_data = []
    ShillerDataMonth.where("long_interest_rate IS NOT NULL").order(:id).each do |sd|
      interest_rates_data << [YearMonth.new(sd.year_month).to_milliseconds, sd.long_interest_rate.round(2)]
    end
    interest_rates_data
  end

  def self.dividend_yield_data_array
    dividend_yield_data = []
    ShillerDataMonth.where("dividends IS NOT NULL AND sp_index IS NOT NULL").order(:id).each do |sd|
      equity_index_data_point = EquityIndexDataPoint.new(price: sd.sp_index, earnings: sd.earnings, dividends: sd.dividends)
      dividend_yield_data << [YearMonth.new(sd.year_month).to_milliseconds, equity_index_data_point.dividend_yield.round(2)]
    end
    dividend_yield_data
  end

  def self.sp_data
    sp_data = []
    ShillerDataMonth.where("real_sp_index IS NOT NULL").order(:id).each do |sd|
      sp_data << [YearMonth.new(sd.year_month).to_milliseconds, sd.real_sp_index.round(2)]
    end
    sp_data
  end

  def self.json_formatting(collection)
    result = []
    collection.each do |shiller_data_month|
      result << shiller_data_month.attributes
    end
    result
  end

  def calc_real_sp_index
    self.inflation_adjustment(sp_index)
  end

  def calc_real_earnings
    self.inflation_adjustment(earnings)
  end

  def calc_real_dividends
    self.inflation_adjustment(dividends)
  end

  def self.records_between_two_dates(start_date, end_date)
    ShillerDataMonth.where("record_date >= ? AND record_date <= ?", start_date, end_date).order("record_date asc")
  end

  private

  def last_record
    ShillerDataMonth.order("record_date desc").limit(1)
  end

  def inflation_adjustment(number)
    InflationAdjustment.new(last_record.cpi, cpi, number)
  end

  def ten_year_average_real_earnings
    start_date = record_date - 121.months
    return nil if (start_date < Date.new(1871, 1))
    ShillerDataMonth.records_between_two_dates(start_date, record_date).average(:real_earnings).to_f
  end

  def calc_cape
    if ten_year_average_real_earnings
      EquityIndex.cape(real_sp_index, ten_year_average_real_earnings)
    end
  end

  def prior_shiller_data_month
    prior_month = YearMonth.new(year_month).prior_month
    return nil if prior_month <= Date.new(1871, 1)
    ShillerDataMonth.find_by_record_date(prior_month)
  end

end
