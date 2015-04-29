# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout Integer(ENV["WEB_TIMEOUT"] || 15)
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2") if Rails.env.wip?
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] ||
                    Rails.application.config.database_configuration[Rails.env]
    # config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds # For Rails 4
    config['pool']            =   ENV['DB_POOL'] || 2

    ActiveRecord::Base.establish_connection(config)
  end
=begin
  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { :size => 5 }
  end
=end
end
