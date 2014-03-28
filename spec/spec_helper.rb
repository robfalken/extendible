require 'bundler/setup'
Bundler.setup

require 'extendible'
require 'active_model_serializers'
require 'fixtures/fixtures'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
end