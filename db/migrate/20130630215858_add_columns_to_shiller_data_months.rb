class AddColumnsToShillerDataMonths < ActiveRecord::Migration
  def change
    add_column :shiller_data_months, :real_sp_index_return, :float
    add_column :shiller_data_months, :dividend_return, :float
    add_column :shiller_data_months, :real_total_return, :float
  end
end
