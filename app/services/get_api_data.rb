class GetApiData
  attr_reader :url

  def initialize
    @from = Time.now - 1.day
    @to = Time.now
    # @url = generate_url
    # @data = get_data
    # @response = get_data
  end

  private

  def generate_url(date)
    "http://data.fixer.io/api/2019-08-15?access_key="
  end

  def get_data
    Net::HTTP.get(URI.parse(url))

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "Bearer " + @auth_token.to_s

    res = http.request(request)
    JSON.parse(res.body)
    "Service works"
  end
end
