Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://172.23.191.240:6380/0' }  # Use the WSL IP address and the default Redis port
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://172.23.191.240:6380/0' }
end
