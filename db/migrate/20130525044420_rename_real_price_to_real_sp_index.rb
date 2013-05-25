class RenameRealPriceToRealSpIndex < ActiveRecord::Migration
  def change
    rename_column :shiller_data_months, :real_price, :real_sp_index
  end
end
