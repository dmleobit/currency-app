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

class Counting < ApplicationRecord
  AVAILABLE_CURRENCIES = %i(
    AUD BGN BRL CAD
    CHF CNY CZK DKK
    EUR GBP HKD HRK
    HUF IDR ILS INR
    JPY KRW MXN MYR
    NOK NZD PHP PLN
    RON RUB SEK SGD
    THB TRY USD ZAR
  )

  belongs_to :user

  validates :amount, presence: true
  validates :basic_currency, presence: true
  validates :target_currency, presence: true
  validates :duration, presence: true

  after_commit :save_cources

  private
  
  def save_cources
    # todo check need or not
    # byebug
    SetHistoryRates.perform_async(duration - 1)
  end
end
