class EquityIndex
  def self.cape(real_sp_index, ten_year_average_real_earnings)
    real_sp_index.to_f / ten_year_average_real_earnings
  end
end
