#!/usr/bin/env ruby

require_relative '../lib/airbridge_deeplink'

# Set API token
AirbridgeDeeplink.api_token = 'your-airbridge-api-token'

# Create client
client = AirbridgeDeeplink::Client.new

# Basic example of creating tracking link
puts "Creating basic tracking link..."
begin
  response = client.create_tracking_link(
    channel: "my-channel"
  )
  puts "Successfully created: #{response}"
rescue => e
  puts "Error: #{e.message}"
end

# Extended example with all parameters
puts "\nCreating extended tracking link..."
begin
  options = {
    channel: "my-channel",
    campaignParams: {
      campaign: "2022_FW_Sale_Festival",
      ad_group: "UA",
      ad_creative: "Coat_840x600"
    },
    isReengagement: "ON-TRUE",
    deeplinkOption: {
      showAlertForInitialDeeplinkingIssue: true
    },
    fallbackPaths: {
      option: {
        iosCustomProductPageId: "5ae82ffe-1f08-428d-b352-ac1c3a22aa1e",
        googlePlayCustomStoreListing: "custom-store-listing"
      }
    },
    ogTag: {
      title: "30% Off Winter Apparel for 3 Days Only",
      description: "Get great deals on apparel to keep you warm this winter",
      imageUrl: "https://static.airbridge.io/images/2021_airbridge_og_tag.png"
    }
  }

  response = client.create_tracking_link(options)
  puts "Successfully created extended tracking link: #{response}"
rescue => e
  puts "Error: #{e.message}"
end

# Error handling example
puts "\nTesting error handling..."
begin
  # Try to create tracking link without channel
  response = client.create_tracking_link({})
rescue ArgumentError => e
  puts "Expected validation error: #{e.message}"
rescue AirbridgeDeeplink::APIError => e
  puts "API error: #{e.message}"
rescue => e
  puts "Unexpected error: #{e.message}"
end