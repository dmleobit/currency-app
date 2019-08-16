class HardWorker
  include Sidekiq::Worker

  def perform(name)
    pp "WORKS"
    # count.times do
    #   pp name
    # end
  end
end
