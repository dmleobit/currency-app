class UpdateLatestRate
  include Sidekiq::Worker

  def perform
    url = "http://data.fixer.io/api/latest?access_key=#{ENV["FIXER_KEY"]}"
    response = DoRequest.call(url)

    GlobalConfig.first.update(latest_rate: response)
    UpdateLatestRate.perform_in(1.hour)
  end
end
