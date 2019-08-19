# == Schema Information
#
# Table name: global_configs
#
#  id          :bigint           not null, primary key
#  latest_rate :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class GlobalConfigTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
