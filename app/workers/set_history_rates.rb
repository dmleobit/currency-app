class SetHistoryRates
  include Sidekiq::Worker

  def perform(duration)
    result = SaveDataFromApi.call(Date.today - duration.to_i)
    raise "We have a problem with API" unless result.success?
  end
end
