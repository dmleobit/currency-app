# == Schema Information
#
# Table name: rate_histories
#
#  id         :bigint           not null, primary key
#  date       :date
#  value      :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RateHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
