class YearMonth
  attr_reader :date

  # initialized with string in yyyy.mm format
  def initialize(input)
    @date = to_date(input)
  end

  def to_date(input)
    year, month = input.split(".")
    Date.new(year.to_i, month.to_i)
  end

  def month
    date.month
  end

  def year
    date.year
  end

  def to_milliseconds
    Time.new(year, month).to_i * 1000
  end

  def prior_month
    date - 1.month
  end
end
