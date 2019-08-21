class SavingFromApi::GetRatesFromApi
  extend LightService::Action

  expects :dates, :url
  promises :rates

  executed do |context|
    context.rates = context.dates.map do |date|
      url = context.url.gsub(":date", date.to_s)
      result = PerformApiCall.call(url)

      context.fail_and_return!("Api does not respond") unless result.success?

      {
        date: date,
        value: result.body[:rates]
      }
    end
  end
end
