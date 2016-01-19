$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Require test dependencies
require 'slack_pomodoro_timer'
require 'webmock/rspec'
require 'figaro'

# Require support files
require 'support/config'

# Load Figaro
Figaro.application = Figaro::Application.new(
  environment: "test",
  path: "config/application.yml"
)
Figaro.load

# Config RSpec
RSpec.configure do |config|
  config.include Support::Config
end

# Allow external HTTP requests
WebMock.allow_net_connect!



