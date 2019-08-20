FactoryBot.define do
  factory :rate_history do
    date  { RateHistory.order(:date).first&.date&.yesterday || Date.today }
    value { rates }
  end
end

def rates
  Counting::AVAILABLE_CURRENCIES.map do |currency|
    [currency, rand]
  end.to_h
end
