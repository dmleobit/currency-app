class SavingFromApi::SaveRates
  extend LightService::Action

  expects :rates

  executed do |context|
    context.rates.each { |rate| RateHistory.create(rate) }
  end
end
