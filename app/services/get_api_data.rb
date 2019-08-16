require 'net/http'

class GetApiData
  attr_reader :response, :data

  def initialize(from)
    @from = from
    @encoded_params = encode_params
    @to = Date.today
    @response = get_dates
    @data = build_object
    save_data
  end

  private

  def encode_params
    params = {
      access_key: ENV["FIXER_KEY"],
      symbols: Counting::AVAILABLE_CURRENCIES.join(",")
    }

    URI.encode_www_form(params)
  end

  def generate_url(date)
    path = "http://data.fixer.io/api/#{date.strftime}"

    [path, @encoded_params].join("?")
  end

  def get_dates
    (@from..@to).map do |date|
      get_data_about_day(date)
    end.compact
  end

  def get_data_about_day(date)
    return nil if RateHistory.exists?(date: date)
    # Net::HTTP.get(URI.parse(url))

    url = generate_url(date)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "Bearer " + @auth_token.to_s

    res = http.request(request)
    
    JSON.parse(res.body).with_indifferent_access
  end

  def build_object
    @response&.map do |day|
      {
        date: day[:date],
        value: day[:rates]
      }
    end
  end

  def save_data
    @data&.each do |record|
      RateHistory.create(record)
    end
  end
end
