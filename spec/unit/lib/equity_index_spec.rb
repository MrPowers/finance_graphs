require "spec_helper"

describe EquityIndex do
  it "calculates the cape" do
    expect(EquityIndex.cape(150, 22)).to be_within(0.01).of(6.82)
  end
end
