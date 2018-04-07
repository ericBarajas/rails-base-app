$redis = Redis.new(:host => Rails.application.secrets.redis_host, :port => Rails.application.secrets.redis_port)

Rails.application.config.redis_prefix = Rails.application.secrets.redis_prefix

