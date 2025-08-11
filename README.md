# AirbridgeDeeplink

Ruby gem for creating Airbridge deeplinks via their API.

## Installation

Add this gem to your Gemfile:

```ruby
gem 'airbridge_deeplink'
```

Or install it directly:

```bash
gem install airbridge_deeplink
```

## Usage

### Basic Configuration

```ruby
# In initializer or config file
AirbridgeDeeplink.api_token = 'your-airbridge-api-token'

# Or through configuration block
AirbridgeDeeplink.configure do |config|
  config.api_token = 'your-airbridge-api-token'
  config.timeout = 30
end
```

### Creating Tracking Links

```ruby
# Create client
client = AirbridgeDeeplink::Client.new

# Basic example
options = {
  channel: "my-channel"
}

response = client.create_tracking_link(options)

# Extended example with all parameters
options = {
  channel: "my-channel",
  campaignParams: {
    campaign: "2022_FW_Sale_Festival",
    ad_group: "UA",
    ad_creative: "Coat_840x600"
  },
  isReengagement: "OFF",
  deeplinkUrl: "openmyapp://festival/38",
  deeplinkOption: {
    showAlertForInitialDeeplinkingIssue: true
  },
  fallbackPaths: {
    android: "google-play",
    ios: "itunes-appstore",
    desktop: "https://example.com"
  },
  ogTag: {
    title: "30% Off Winter Apparel for 3 Days Only",
    description: "Get great deals on apparel to keep you warm this winter",
    imageUrl: "https://static.airbridge.io/images/2021_airbridge_og_tag.png"
  }
}

response = client.create_tracking_link(options)
```

## API Parameters

### Required Parameters

- `channel` - Channel name for tracking link

### Optional Parameters

- `campaignParams` - Campaign parameters
  - `campaign` - Campaign name
  - `ad_group` - Ad group
  - `ad_creative` - Ad creative
- `isReengagement` - Re-engagement parameter ("ON-TRUE" or "OFF-FALSE")
- `deeplinkUrl` - Configure the Deeplink URL for redirect.
- `deeplinkOption` - Deeplink settings
  - `showAlertForInitialDeeplinkingIssue` - Show alert for deeplink issues
- `fallbackPaths` - Fallback paths
  - `android` - Redirect android user to google-play, airpage or http(s) url
  - `ios` - Redirect iOS user to itunes-appstore, airpage or http(s) url
  - `desktop` - Redirect desktop user to google-play, itunes-appstore or http(s) url
  - `option` - Fallback options
    - `iosCustomProductPageId` - iOS custom product page ID
    - `googlePlayCustomStoreListing` - Google Play custom store listing
- `ogTag` - Open Graph tags
  - `title` - Title
  - `description` - Description
  - `imageUrl` - Image URL

## Error Handling

The gem provides specific error classes:

```ruby
begin
  response = client.create_tracking_link(options)
rescue AirbridgeDeeplink::ConfigurationError => e
  puts "Configuration error: #{e.message}"
rescue AirbridgeDeeplink::APIError => e
  puts "API error: #{e.message}"
rescue ArgumentError => e
  puts "Invalid parameters: #{e.message}"
end
```

## Development

After cloning the repository, run:

```bash
bundle install
```

To run tests:

```bash
bundle exec rspec
```

## License

This gem is available under the MIT license. See the LICENSE file for details.

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
