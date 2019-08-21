FactoryBot.define do
  sequence(:date) { |index| index.days.ago.to_date }

  factory :rate_history do
    date  { generate(:date) }
    value do
      Counting::AVAILABLE_CURRENCIES.map { |currency| [currency, rand] }.to_h
    end
  end
end
