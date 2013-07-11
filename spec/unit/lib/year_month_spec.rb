require "spec_helper"

describe YearMonth do
  let(:year_month) { YearMonth.new("2011.01") }

  it "converts yyyy.mm to a date object" do
    expect(year_month.date).to eq(Date.new(2011, 1))
  end

  it "returns month" do
    expect(year_month.month).to eq(1)
  end

  it "returns year" do
    expect(year_month.year).to eq(2011)
  end

  it "returns milliseconds since epoch" do
    expect(year_month.to_milliseconds).to eq(1293858000000)
  end
end
