# config/initializers/airbridge_deeplink.rb

# Configure AirbridgeDeeplink gem
AirbridgeDeeplink.configure do |config|
  # Set API token from environment variable
  config.api_token = ENV['AIRBRIDGE_API_TOKEN']

  # Optionally: configure timeout (default is 30 seconds)
  config.timeout = 30

  # Optionally: change base URL (default is https://api.airbridge.io/v1)
  # config.base_url = "https://api.airbridge.io/v1"
end

# Check if API token is set
unless AirbridgeDeeplink.api_token
  Rails.logger.warn "AirbridgeDeeplink: AIRBRIDGE_API_TOKEN is not set in environment variables"
end