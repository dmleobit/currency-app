class SavingFromApi::SaveRates
  extend LightService::Action

  expects :rates

  executed do |context|
    context.rates.each do |rate|
      RateHistory.create(rate)
    end
  end
end
