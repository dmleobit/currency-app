require "net/http"
# return OpenStruct with method success? and body
class DoRequest
  def self.call(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return OpenStruct.new(success?: false) unless response.code.eql?("200")

    response_body = JSON.parse(response.body).with_indifferent_access   
    OpenStruct.new(success?: response_body["success"] ? true : false, body: response_body)
  end
end
