# frozen_string_literal: true

require_relative 'lib/airbridge_deeplink/version'

Gem::Specification.new do |spec|
  spec.name          = 'airbridge_deeplink'
  spec.version       = AirbridgeDeeplink::VERSION
  spec.authors       = ['superp']
  spec.email         = ['superp1987@gmail.com']

  spec.summary       = 'Ruby gem for creating Airbridge deeplinks via their API'
  spec.description   = 'A simple Ruby gem to interact with Airbridge API for creating tracking links and deeplinks'
  spec.homepage      = 'https://github.com/superp/airbridge_deeplink'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Add dependencies
  spec.add_dependency 'httparty'
  spec.add_dependency 'json'

  # Add development dependencies
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 6.1'
  spec.add_development_dependency 'webmock', '~> 3.18'
end
