web: bundle exec puma -C config/puma.rb
worker: QUEUES=mailers,tasks rake jobs:work