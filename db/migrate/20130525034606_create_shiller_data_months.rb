class CreateShillerDataMonths < ActiveRecord::Migration
  def change
    create_table :shiller_data_months do |t|
      t.string :year_month
      t.float :sp_index
      t.float :dividends
      t.float :earnings
      t.float :cpi
      t.float :long_interest_rate
      t.date :date_fraction
      t.float :real_price
      t.float :real_dividends
      t.float :real_earnings
      t.float :cape

      t.timestamps
    end
  end
end
