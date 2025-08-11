# frozen_string_literal: true

module AirbridgeDeeplink
  class Configuration
    attr_accessor :api_token, :base_url, :timeout

    def initialize
      @api_token = nil
      @base_url = 'https://api.airbridge.io/v1'
      @timeout = 30
    end

    def validate!
      raise ConfigurationError, 'API token is required' if api_token.blank?
    end
  end
end
