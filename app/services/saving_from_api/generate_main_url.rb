class SavingFromApi::GenerateMainUrl
  ENDPOINT_URL = "http://data.fixer.io/api/:date".freeze
  PARAMS = {
    access_key: ENV["FIXER_KEY"],
    symbols: Counting::AVAILABLE_CURRENCIES.join(",")
  }.freeze

  extend LightService::Action

  promises :url

  executed do |context|
    encoded_params = URI.encode_www_form(PARAMS)
    context.url = "#{ENDPOINT_URL}?#{encoded_params}"
  end
end
