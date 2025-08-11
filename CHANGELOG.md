# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-08-11

### Added
- Initial release of AirbridgeDeeplink gem
- Basic configuration system with API token support
- Client class for interacting with Airbridge API
- `create_tracking_link` method with full parameter support
- Comprehensive error handling for API responses
- Full test coverage with RSpec and WebMock
- English documentation and examples
- Support for all Airbridge API parameters:
  - channel (required)
  - campaignParams (campaign, ad_group, ad_creative)
  - isReengagement
  - deeplinkOption
  - fallbackPaths
  - ogTag

### Dependencies
- HTTParty for HTTP requests
- JSON for JSON parsing
- RSpec, WebMock, VCR for testing