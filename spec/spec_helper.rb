$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slack_pomodoro_timer'
require 'webmock/rspec'
WebMock.allow_net_connect!
