require 'spec_helper'

describe EquityIndexDataPoint do
  let(:data_point) { EquityIndexDataPoint.new({price: 100, earnings: 8.5, dividends: 5.43}) }

  it "calculates the price to earnings ratio" do
    expect(data_point.price_to_earnings).to be_within(0.01).of(11.76)
  end

  it "calculates the dividend yield" do
    expect(data_point.dividend_yield).to be_within(0.0001).of(0.0543)
  end
end
