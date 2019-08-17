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
    all_dates = context.from.upto(Date.today).to_a
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
      api_data = DoRequest.call(url)

      {date: api_data[:date],
       value: day[:rates]}
    end
  end
end

class SaveRates
  extend LightService::Action

  expects :rates
  
  executed do |context|
    context.rates.each do |rate|
      RateHistory.create(record)
    end
  end
end
