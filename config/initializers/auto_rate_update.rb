require "sidekiq"
require "sidekiq/api"
require "sidekiq/testing" if Rails.env.test?

ss = Sidekiq::ScheduledSet.new
ss.select {|retri| retri.klass == "UpdateLatestRateWorker" }.each(&:delete)
UpdateLatestRateWorker.perform_async
