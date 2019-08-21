# return OpenStruct with method success? and body
class PerformApiCall
  SUCCESS_CODE = 200

  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call
    perform_request!
    @response.code.to_i.eql?(SUCCESS_CODE) ? parse_response : failure_object
  end

  private

  def perform_request!
    uri = URI.parse(@url)
    net_http_object = Net::HTTP.new(uri.host, uri.port)
    request_object = Net::HTTP::Get.new(uri.request_uri)

    @response = net_http_object.request(request_object)
  end

  def parse_response
    body = JSON.parse(@response.body).with_indifferent_access
    return failure_object unless body["success"]

    OpenStruct.new(success?: true, body: body)
  end

  def failure_object
    OpenStruct.new(success?: false)
  end
end
