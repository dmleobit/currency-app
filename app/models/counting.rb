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
  ).freeze

  belongs_to :user

  validates :amount, :basic_currency, :target_currency, :duration, presence: true
  validates :duration, numericality: { less_than_or_equal_to: 50,  only_integer: true }

  after_commit :save_rates

  def duration_in_days
    duration * 7
  end

  private

  def save_rates
    # TODO: check need or not
    SetHistoryRatesWorker.perform_async(duration_in_days)
  end
end
