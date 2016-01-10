$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Require test dependencies
require 'slack_pomodoro_timer'
require 'webmock/rspec'

# Require support files
require 'support/config'

RSpec.configure do |config|
  config.include Support::Config
end

# Allow external HTTP requests
WebMock.allow_net_connect!

