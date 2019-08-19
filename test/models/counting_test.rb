# == Schema Information
#
# Table name: countings
#
#  id              :bigint           not null, primary key
#  amount          :float            default(0.0)
#  basic_currency  :string
#  duration        :integer
#  target_currency :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint
#
# Indexes
#
#  index_countings_on_user_id  (user_id)
#

require "test_helper"

class CountingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
