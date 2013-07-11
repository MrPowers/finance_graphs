class InflationAdjustment
  attr_reader :current_value, :current_cpi, :future_cpi
  def initialize(current_value, current_cpi, future_cpi)
    @current_value = current_value
    @current_cpi = current_cpi
    @future_cpi = future_cpi
  end

  def compute
    future_cpi / current_cpi * current_value
  end
end
