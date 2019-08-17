require 'sidekiq/api'

ss = Sidekiq::ScheduledSet.new
jobs = ss.select {|retri| retri.klass == 'UpdateLatestRate' }
UpdateLatestRate.perform_async if jobs.blank?
