require "rails_helper"
require "light-service/testing"

RSpec.describe SavingFromApi::SaveRates do
  let(:n_days)  { 35 }
  let(:context) do
    LightService::Testing::ContextFactory
      .make_from(SaveDataFromApi)
      .for(described_class)
      .with(n_days.days.ago.to_date)
  end

  it "works like it should" do
    expect(RateHistory.count.zero?).to be_truthy

    VCR.use_cassette("rates/daily_rate", erb: true, allow_playback_repeats: true, match_requests_on: %i(uri_ignoring_date)) do
      result = described_class.execute(context)

      expect(RateHistory.count).to eq(n_days)
      expect(result.dates).to be_truthy
      expect(result).to be_success
    end
  end
end
