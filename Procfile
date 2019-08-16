web: bundle exec puma -t 5:5 -p $PORT -e $RAILS_ENV
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -l sidekiq.log
release: rake db:migrate
