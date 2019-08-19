require "sidekiq/api"

ss = Sidekiq::ScheduledSet.new
ss.select {|retri| retri.klass == "UpdateLatestRate" }.each(&:delete)
UpdateLatestRate.perform_async
