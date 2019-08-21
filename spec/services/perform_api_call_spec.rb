require "rails_helper"

RSpec.describe PerformApiCall, type: :service do
  subject { service.call(url) }

  let(:url) { "http://data.fixer.io/api/latest?access_key=#{ENV['FIXER_KEY']}" }

  context "All success" do
    it "Check returned fields" do
      VCR.use_cassette("rates/latest", match_requests_on: %i(uri_without_access_key)) do
        result = described_class.call(url)
        expect(result.success?).to be_truthy
      end
    end
  end
end
