require 'net/http'

class GetApiData
  attr_reader :response, :data

  def initialize
    @from = Date.today - 1.day
    @to = Date.today
    @urls = generate_urls
    # @data = get_data
    # @response = get_data
    @data = build_object
    save_data
  end

  private

  def generate_urls
    params = {
      access_key: ENV["FIXER_KEY"],
      symbols: Counting::AVAILABLE_CURRENCIES.join(",")
    }

    (@from..@to).map do |date|
      path = "http://data.fixer.io/api/#{date.strftime}"
   
      encoded_params = URI.encode_www_form(params)
      [path, encoded_params].join("?")
    end
  end

  def get_data
    @urls.map do |url|
      # Net::HTTP.get(URI.parse(url))

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      request["Authorization"] = "Bearer " + @auth_token.to_s

      res = http.request(request)
      
      JSON.parse(res.body).with_indifferent_access
    end
  end

  def build_object
    @response.map do |day|
      pp day
      {
        date: day[:date],
        value: day[:rates]
      }
    end
  end

  def save_data
    @data.each do |record|
      RateHistory.create(record)
    end
  end
end
