class UpdateLatestRateWorker
  include Sidekiq::Worker

  def perform
    UpdateLatestRate.call
    UpdateLatestRateWorker.perform_in(1.hour)
  end
end
