require "sidekiq"
require "sidekiq/api"
require "sidekiq/testing" if Rails.env.test?

ss = Sidekiq::ScheduledSet.new
ss.select {|retri| retri.klass == "UpdateLatestRate" }.each(&:delete)
UpdateLatestRate.perform_async
