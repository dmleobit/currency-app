class SaveDataFromApi
  extend LightService::Organizer

  def self.call(from)
    with(from: from).reduce(
        # We can move this class in separate files if need 
        GenerateMainUrl,
        GetDates,
        GetRatesFromApi,
        SaveRates
      )
  end
end

class GenerateMainUrl
  extend LightService::Action

  promises :url

  executed do |context|
    params = {
      access_key: ENV["FIXER_KEY"],
      symbols: Counting::AVAILABLE_CURRENCIES.join(",")
    }
    encoded_params = URI.encode_www_form(params)

    path = "http://data.fixer.io/api/:date"
    context.url = [path, encoded_params].join("?")
  end
end

class GetDates
  extend LightService::Action

  expects :from
  promises :dates

  executed do |context|
    all_dates = context.from.upto(Date.today - 1).to_a
    exists_dates = RateHistory.where(date: all_dates).pluck(:date)
    
    context.dates = all_dates - exists_dates
    context.skip_remaining!("Dates is blank") if context.dates.blank?
  end
end

class GetRatesFromApi
  extend LightService::Action

  expects :dates, :url
  promises :rates

  executed do |context|
    context.rates = context.dates.map do |date|
      url = context.url.gsub(":date", date.to_s)
      result = DoRequest.call(url)

      context.fail_and_return!("Api does not respond") unless result.success?

      {date: result.body[:date],
       value: result.body[:rates]}
    end
  end
end

class SaveRates
  extend LightService::Action

  expects :rates
  
  executed do |context|
    context.rates.each do |rate|
      RateHistory.create(rate)
    end
  end
end
