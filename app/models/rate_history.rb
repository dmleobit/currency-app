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

class RateHistory < ApplicationRecord
  validates :date, presence: true
  validates :value, presence: true

  validates :date, uniqueness: true
end
