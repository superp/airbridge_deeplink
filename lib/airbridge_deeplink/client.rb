# frozen_string_literal: true

require 'httparty'

module AirbridgeDeeplink
  class Client
    include HTTParty

    base_uri 'https://api.airbridge.io/v1'
    headers 'Content-Type' => 'application/json'
    default_timeout 30

    def initialize(config = nil)
      @config = config || AirbridgeDeeplink.configuration
      @config.validate!

      self.class.headers 'Authorization' => "Bearer #{@config.api_token}"
    end

    def create_tracking_link(options = {})
      validate_tracking_link_options(options)

      response = self.class.post('/tracking-links', body: options.to_json)

      handle_response(response)
    end

    private

    def validate_tracking_link_options(options)
      required_fields = [:channel]
      missing_fields = required_fields.select { |field| options[field].nil? || options[field].to_s.empty? }

      if missing_fields.any?
        raise ArgumentError, "Missing required fields: #{missing_fields.join(', ')}"
      end
    end

    def handle_response(response)
      case response.code
      when 200, 201
        JSON.parse(response.body)
      when 400
        raise APIError, "Bad Request: #{response.body}"
      when 401
        raise APIError, 'Unauthorized: Invalid API token'
      when 403
        raise APIError, 'Forbidden: Insufficient permissions'
      when 404
        raise APIError, "Not Found: #{response.body}"
      when 429
        raise APIError, 'Rate Limited: Too many requests'
      when 500..599
        raise APIError, "Server Error: #{response.body}"
      else
        raise APIError, "Unexpected response (#{response.code}): #{response.body}"
      end
    rescue JSON::ParserError
      raise APIError, "Invalid JSON response: #{response.body}"
    end
  end
end
