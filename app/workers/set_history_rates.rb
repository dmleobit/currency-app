class SetHistoryRates
  include Sidekiq::Worker

  def perform(duration)
    SaveDataFromApi.call(Date.today - duration.to_i)
  end
end
