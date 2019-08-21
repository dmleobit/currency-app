class UpdateLatestRate
  URL = "http://data.fixer.io/api/latest?access_key=#{ENV['FIXER_KEY']}".freeze

  def self.call
    new.call
  end

  def initialize; end

  def call
    return unless check_latest_update

    call_api!
    update_rate_history!
    update_latest_rate!
  end

  private

  # return true if we need update data
  def check_latest_update
    time_latest_update = Time.at(GlobalConfig["latest_rate"]["timestamp"])
    time_hour_ago = 1.hour.ago.to_time

    time_latest_update < time_hour_ago
  end

  def call_api!
    @result = PerformApiCall.call(URL)
    raise "API does not respond" unless @result.success?
  end

  def update_rate_history!
    duration = (RateHistory.order(:date).last.date - Date.yesterday).to_i.abs
    SetHistoryRatesWorker.perform_async(duration) if duration.positive?
  end

  def update_latest_rate!
    GlobalConfig.first.update(latest_rate: @result.body)
  end
end
