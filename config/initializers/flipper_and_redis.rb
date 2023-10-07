module Features
  def self.flipper
    Flipper
  end
end

redis_config = {
  url: ENV['REDIS_URL'],
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
}

REDIS = ConnectionPool.new(size: ENV.fetch('REDIS_POOL_SIZE', 10), timeout: 3) do
  Redis.new(redis_config)
end

Flipper.configure do |config|
  REDIS.with do |conn|
    config.adapter { Flipper::Adapters::Redis.new(conn) }
  end
end

Flipper.register(:super_admins) do |actor|
  actor.respond_to?(:super_admin?) && actor.super_admin?
end
