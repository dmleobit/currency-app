class SavingFromApi::GenerateMainUrl
  PATH = "http://data.fixer.io/api/:date".freeze
  PARAMS = {
    access_key: ENV["FIXER_KEY"],
    symbols: Counting::AVAILABLE_CURRENCIES.join(",")
  }.freeze

  extend LightService::Action

  promises :url

  executed do |context|
    encoded_params = URI.encode_www_form(PARAMS)
    context.url = [PATH, encoded_params].join("?")
  end
end
