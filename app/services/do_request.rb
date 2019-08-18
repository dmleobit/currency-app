require 'net/http'
# return body from response
class DoRequest
  # todo check if status not 200
  def self.call(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    JSON.parse(response.body).with_indifferent_access
  end
end
