class UpdateLatestRate
  include Sidekiq::Worker
  URL = "http://data.fixer.io/api/latest?access_key=#{ENV["FIXER_KEY"]}"

  def perform
    result = DoRequest.call(URL)

    raise "API does not respond" unless result.success?

    duration = (RateHistory.order(:date).last.date - Date.today).to_i.abs
    SetHistoryRates.perform_async(duration) if duration.positive?

    GlobalConfig.first.update(latest_rate: result.body)
    UpdateLatestRate.perform_in(1.hour)
  end
end
