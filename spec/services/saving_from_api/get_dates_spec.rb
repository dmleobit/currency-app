require "rails_helper"
require "light-service/testing"

RSpec.describe SavingFromApi::GetDates do
  let(:context) do
    LightService::Testing::ContextFactory
      .make_from(SaveDataFromApi)
      .for(described_class)
      .with(Date.today - 3.week)
  end

  it "works like it should" do
    result = described_class.execute(context)

    expect(result.dates).to be_truthy
    expect(result).to be_success
  end
end
