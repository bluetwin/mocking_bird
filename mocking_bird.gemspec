# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mocking_bird/version'

Gem::Specification.new do |spec|
  spec.name          = "mocking_bird"
  spec.version       = MockingBird::VERSION
  spec.authors       = ["Brandon Sislow"]
  spec.email         = ["bsislow@avvo.com"]
  spec.summary       = %q{Mock manager for cross services mocks}
  spec.description   = %q{A mock manager to load mocks based on convention, similar to fixtures, while being fetchable}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json_api_client_mock"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
