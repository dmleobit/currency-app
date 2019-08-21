require "rails_helper"

RSpec.describe CollectDataForShow, type: :service do
  subject { service.call }

  let(:user)     { create(:user) }
  let(:counting) { create(:counting, user: user) }
  let(:service)  { described_class.new(counting) }

  context "All success" do
    before do
      40.times { create(:rate_history) }
    end

    it "Check returned fields" do
      needed_fields = %i(table_data chart_data weeks_rates data_is_loading).sort
      check_fields = (service.methods.sort & needed_fields).eql?(needed_fields)

      expect(check_fields).to be_truthy
    end
  end
end
