

 if Rails.env.production?

 
    Sidekiq.configure_client do |config|
      config.redis = { url: ENV.fetch('REDISCLOUD_URL')}
    end

    Sidekiq.configure_server do |config|
      config.redis = { url: ENV.fetch('REDISCLOUD_URL') }
    end
else 

    Sidekiq.configure_client do |config|
        config.redis = { url: ENV['REDIS_PROVIDER'] }
      end
    
    Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDIS_PROVIDER'] }
    end


end
  
