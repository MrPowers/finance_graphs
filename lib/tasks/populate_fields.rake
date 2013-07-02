namespace :populate_fields do
  desc "Populates the real earnings field based on nominal earnings"
  task real_earnings: :environment do
    shiller_data_months = ShillerDataMonth.where("earnings IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.real_earnings = sd.calc_real_earnings
      sd.save!
    end
  end

  desc "Populates the real dividend field based on nominal dividends"
  task real_dividends: :environment do
    shiller_data_months = ShillerDataMonth.where("dividends IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:real_dividends, sd.calc_real_dividends)
    end
  end

  desc "Populates the real S&P index"
  task real_sp_index: :environment do
    shiller_data_months = ShillerDataMonth.where("sp_index IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:real_sp_index, sd.calc_real_sp_index)
    end
  end

  desc "Populates the cape"
  task cape: :environment do
    shiller_data_months = ShillerDataMonth.where("real_sp_index IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:cape, sd.calc_cape)
    end
  end

  desc "Populates the real_sp_index_return"
  task real_sp_index_return: :environment do
    shiller_data_months = ShillerDataMonth.where("real_sp_index IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:real_sp_index_return, sd.real_sp_index_return)
    end
  end

  desc "Populates the dividend_return"
  task dividend_return: :environment do
    shiller_data_months = ShillerDataMonth.where("dividends IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:dividend_return, sd.dividend_return)
    end
  end

  desc "Populates the real_total_return"
  task real_total_return: :environment do
    shiller_data_months = ShillerDataMonth.where("dividend_return IS NOT NULL AND real_sp_index_return IS NOT NULL")
    shiller_data_months.each do |sd|
      sd.update_attribute(:real_total_return, sd.real_total_return)
    end
  end

  desc "Add trailing 0 to November year_month - change 2011.1 to 2011.10"
  task add_trailing_zero: :environment do
    shiller_data_months = ShillerDataMonth.all.select { |sd| sd.year_month.length == 6 }
    shiller_data_months.each do |sd|
      sd.year_month = sd.year_month + "0"
      sd.save!
    end
  end

  desc "Populate record_date"
  task record_date: :environment do
    shiller_data_months = ShillerDataMonth.where("year_month IS NOT NULL")
    shiller_data_months.each do |sd|
      year, month = sd.year_month.split(".")
      sd.update_attribute(:record_date, Date.new(year.to_i, month.to_i))
    end
  end

end
