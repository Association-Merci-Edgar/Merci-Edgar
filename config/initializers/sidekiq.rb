ENV["REDIS_URL"] ||= ENV["REDISTOGO_URL"] ||= "redis://localhost:6379"

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=8"
    ActiveRecord::Base.establish_connection
  end
end