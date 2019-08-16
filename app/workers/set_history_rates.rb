class SetHistoryRates
  include Sidekiq::Worker

  def perform(duration)
    GetApiData.new(Date.today - duration)
  end
end
