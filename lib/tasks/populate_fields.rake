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
end
