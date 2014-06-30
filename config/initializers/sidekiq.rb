ENV["REDIS_URL"] ||= ENV["REDISTOGO_URL"] ||= "redis://localhost:6379"

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }

  database_url = ENV['DATABASE_URL']
  sidekiq_concurrency = ENV['SIDEKIQ_CONCURRENCY']
  if(database_url && sidekiq_concurrency)
    Rails.logger.info("Setting custom connection pool size of #{sidekiq_concurrency} for Sidekiq Server")

    ENV['DATABASE_URL'] = "#{database_url}?pool=#{ENV['DB_POOL']}"
    Rails.logger.info(%Q(DATABASE_URL => "#{ENV['DATABASE_URL']}"))

    ActiveRecord::Base.establish_connection
  end

  Rails.logger.info("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
end