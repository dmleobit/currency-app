class UpdateLatestRate
  include Sidekiq::Worker

  URL = "http://data.fixer.io/api/latest?access_key=#{ENV['FIXER_KEY']}".freeze

  def perform
    return unless check_latest_update

    result = PerformApiCall.call(URL)
    raise "API does not respond" unless result.success?

    duration = (RateHistory.order(:date).last.date - Date.yesterday).to_i.abs
    SetHistoryRates.perform_async(duration) if duration.positive?

    GlobalConfig.first.update(latest_rate: result.body)
    UpdateLatestRate.perform_in(1.hour)
  end

  # return true if we need update data
  def check_latest_update
    time_latest_update = Time.at(GlobalConfig["latest_rate"]["timestamp"])
    time_hour_ago = 1.hour.ago.to_time

    time_latest_update < time_hour_ago
  end
end
