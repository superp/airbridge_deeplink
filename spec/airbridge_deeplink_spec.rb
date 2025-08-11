# frozen_string_literal: true
#
require 'spec_helper'

RSpec.describe AirbridgeDeeplink do
  describe '.configuration' do
    it 'returns a configuration instance' do
      expect(AirbridgeDeeplink.configuration).to be_a(AirbridgeDeeplink::Configuration)
    end
  end

  describe '.configure' do
    it 'yields configuration instance' do
      AirbridgeDeeplink.configure do |config|
        expect(config).to be_a(AirbridgeDeeplink::Configuration)
      end
    end
  end

  describe '.api_token=' do
    it 'sets the api token' do
      AirbridgeDeeplink.api_token = 'test-token'
      expect(AirbridgeDeeplink.api_token).to eq('test-token')
    end
  end
end

RSpec.describe AirbridgeDeeplink::Configuration do
  let(:config) { AirbridgeDeeplink::Configuration.new }

  describe '#initialize' do
    it 'sets default values' do
      expect(config.api_token).to be_nil
      expect(config.base_url).to eq('https://api.airbridge.io/v1')
      expect(config.timeout).to eq(30)
    end
  end

  describe '#validate!' do
    context 'when api_token is nil' do
      it 'raises ConfigurationError' do
        expect { config.validate! }.to raise_error(AirbridgeDeeplink::ConfigurationError)
      end
    end

    context 'when api_token is empty' do
      before { config.api_token = '' }
      it 'raises ConfigurationError' do
        expect { config.validate! }.to raise_error(AirbridgeDeeplink::ConfigurationError)
      end
    end

    context 'when api_token is set' do
      before { config.api_token = 'valid-token' }
      it 'does not raise error' do
        expect { config.validate! }.not_to raise_error
      end
    end
  end
end

RSpec.describe AirbridgeDeeplink::Client do
  let(:api_token) { 'test-api-token' }
  let(:client) { AirbridgeDeeplink::Client.new }

  before do
    AirbridgeDeeplink.api_token = api_token
  end

  describe '#initialize' do
    it 'validates configuration' do
      expect_any_instance_of(AirbridgeDeeplink::Configuration).to receive(:validate!)
      AirbridgeDeeplink::Client.new
    end
  end

  describe '#create_tracking_link' do
    let(:options) { { channel: 'test-channel' } }
    let(:success_response) { { 'id' => '123', 'url' => 'https://example.com' } }

    context 'with valid options' do
      before do
        stub_request(:post, "https://api.airbridge.io/v1/tracking-links")
          .with(
            body: options.to_json,
            headers: {
              'Authorization' => "Bearer #{api_token}",
              'Content-Type' => 'application/json'
            }
          )
          .to_return(status: 200, body: success_response.to_json)
      end

      it 'creates tracking link successfully' do
        response = client.create_tracking_link(options)
        expect(response).to eq(success_response)
      end
    end

    context 'with missing channel' do
      it 'raises ArgumentError' do
        expect { client.create_tracking_link({}) }.to raise_error(ArgumentError, /Missing required fields/)
      end
    end

    context 'with empty channel' do
      it 'raises ArgumentError' do
        expect { client.create_tracking_link(channel: '') }.to raise_error(ArgumentError, /Missing required fields/)
      end
    end

    context 'when API returns 401' do
      before do
        stub_request(:post, "https://api.airbridge.io/v1/tracking-links")
          .to_return(status: 401, body: 'Unauthorized')
      end

      it 'raises APIError' do
        expect { client.create_tracking_link(options) }.to raise_error(AirbridgeDeeplink::APIError, /Unauthorized/)
      end
    end

    context 'when API returns 400' do
      before do
        stub_request(:post, "https://api.airbridge.io/v1/tracking-links")
          .to_return(status: 400, body: 'Bad Request')
      end

      it 'raises APIError' do
        expect { client.create_tracking_link(options) }.to raise_error(AirbridgeDeeplink::APIError, /Bad Request/)
      end
    end
  end
end
