class SetHistoryRates
  include Sidekiq::Worker

  def perform(duration)
    GetApiData.new(Date.today - duration.to_i)
  end
end
