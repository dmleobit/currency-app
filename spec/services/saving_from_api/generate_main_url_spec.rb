require "rails_helper"
require "light-service/testing"

RSpec.describe SavingFromApi::GenerateMainUrl do
  let(:context) do
    LightService::Testing::ContextFactory
      .make_from(SaveDataFromApi)
      .for(described_class)
      .with(3.week.from_now.to_date)
  end

  it "works like it should" do
    result = described_class.execute(context)

    expect(result.url).to be_truthy
    expect(result).to be_success
  end
end
