class EquityIndexDataPoint
  attr_reader :price, :earnings, :dividends

  def initialize(args)
    @price = args[:price]
    @earnings = args[:earnings]
    @dividends = args[:dividends]
  end

  def price_to_earnings
    price / earnings * 100
  end

  def dividend_yield
    dividends / price * 100
  end

end
