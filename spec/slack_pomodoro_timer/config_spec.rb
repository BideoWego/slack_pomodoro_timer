require 'slack_pomodoro_timer/config'

describe SlackPomodoroTimer::Config do
  let(:config) { SlackPomodoroTimer::Config }
  let(:fake_config_path) { "#{Dir.pwd}/fixtures/config"}

  before do
    config.class_variable_set(:@@config_file, fake_config_path)
  end

  describe '#add' do
    it 'adds a url to the config file' do
      config.add(url: "www.slack.com")
      expect(read_config).to match "www.slack.com"
    end

    it 'adds a channel to the config file' do
      config.add(channel: "test")
      expect(read_config).to match "test"
    end

    it 'adds a integration type to the config file' do
      config.add(type: "slackbot")
      expect(read_config).to match "slackbot"
    end
  end
end

def write_config
  File.open(fake_config_path, "w+") do |file|
    file.write yield
  end
end

def read_config
  File.read(fake_config_path)
end
