class SetHistoryRatesWorker
  include Sidekiq::Worker

  def perform(duration)
    result = SaveDataFromApi.call(duration.to_i.days.ago.to_date)
    raise "We have a problem with API" unless result.success?
  end
end
