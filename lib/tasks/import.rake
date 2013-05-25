require "csv"

namespace :import do
  desc "Import Shiller data to application"
  task :shiller_data => :environment do
    data_file = (Rails.root + 'ShillerDataMonth.csv')
    data = CSV.readlines(data_file)
    data[1..-1].each do |year_month, sp_index, dividends, earnings, cpi, long_interest_rate, _|
      ShillerDataMonth.create(
        year_month: year_month,
        sp_index: sp_index,
        dividends: dividends,
        earnings: earnings,
        cpi: cpi,
        long_interest_rate: long_interest_rate
        )
    end
  end
end
