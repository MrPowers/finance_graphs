class RenameColumninShillerDataMonths < ActiveRecord::Migration
  def change
    rename_column :shiller_data_months, :date_fraction, :record_date
  end
end
