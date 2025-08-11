# frozen_string_literal: true

require 'airbridge_deeplink/version'
require 'airbridge_deeplink/client'
require 'airbridge_deeplink/configuration'
require 'httparty'
require 'json'
require 'delegate'

module AirbridgeDeeplink
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class APIError < Error; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def api_token
      configuration.api_token
    end

    def api_token=(token)
      configuration.api_token = token
    end
  end
end
