require "spec_helper"

describe InflationAdjustment do
  let(:inflation_adjustment) { InflationAdjustment.new(125, 18.96, 25.46) }

  it "adjusts the current value for inflation" do
    expect(inflation_adjustment.compute).to be_within(0.01).of(167.85)
  end
end
