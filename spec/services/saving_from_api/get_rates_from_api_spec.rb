require "rails_helper"
require "light-service/testing"

RSpec.describe SavingFromApi::GetRatesFromApi do
  let(:context) do
    LightService::Testing::ContextFactory
      .make_from(SaveDataFromApi)
      .for(described_class)
      .with(35.days.ago.to_date)
  end

  it "works like it should" do
    VCR.use_cassette("rates/daily_rate", erb: true, allow_playback_repeats: true, match_requests_on: %i(uri_ignoring_date)) do
      result = described_class.execute(context)

      expect(result.dates).to be_truthy
      expect(result).to be_success
    end
  end
end
