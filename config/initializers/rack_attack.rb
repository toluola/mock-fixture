class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip ||	"207.254.16.35" = req.ip || "207.254.16.36" = req.ip
    || "207.254.16.37" = req.ip || "207.254.16.38" = req.ip || "207.254.16.39" = req.ip
  end
  throttle('req/ip', limit: 10, period: 20) do |req|
    req.ip
  end
  self.throttled_response = ->(env) {
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
      [{error: "Throttle limit reached. Retry later."}.to_json]
    ]
  }
end