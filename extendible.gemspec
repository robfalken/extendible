# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extendible/version'

Gem::Specification.new do |spec|
  spec.name          = "extendible"
  spec.version       = Extendible::VERSION
  spec.authors       = ["Robert Falkén"]
  spec.email         = ["f@lken.se"]
  spec.description   = %q{Makes ActiveModel::Serializer objects extendible by URL parameters}
  spec.summary       = %q{Serializer extension}
  spec.homepage      = "https://github.com/robertfalken/extendible"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'active_model_serializers'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
