class UpdateLatestRate
  include Sidekiq::Worker

  def perform
    url = "http://data.fixer.io/api/latest?access_key=#{ENV["FIXER_KEY"]}"
    response = DoRequest.call(url)

    duration = (RateHistory.order(:date).last.date - Date.today).to_i.abs
    SetHistoryRates.perform_async(duration) if duration.positive?

    GlobalConfig.first.update(latest_rate: response)
    UpdateLatestRate.perform_in(1.hour)
  end
end
