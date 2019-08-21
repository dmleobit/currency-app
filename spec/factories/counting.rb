FactoryBot.define do
  factory :counting do
    amount { rand(1..1000) }
    duration { 5 }
    basic_currency { Counting::AVAILABLE_CURRENCIES.sample }
    target_currency { Counting::AVAILABLE_CURRENCIES.sample }

    user
  end
end
