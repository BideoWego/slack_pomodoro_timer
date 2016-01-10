require 'yaml'

module SlackPomodoroTimer
  class Config

    @@config_file = "#{Dir.home}/.slack_pomodoro_timer"

    def self.config
      @@config ||= self.load_config
    end

    def self.add(url: nil, channel: nil, type: nil)
      config[:channel] = channel if channel
      config[:url] = url if url
      config[:type] = type if type
      save
    end

    def self.save
      File.open(@@config_file, 'w+') do |f|
        f.write(YAML.dump(config))
      end
    end

    def self.load_config
      begin
        YAML.load_file(@@config_file)
      rescue
        {channel: nil, url: nil}
      end
    end

    def self.get(key)
      config[key]
    end

    def self.display
      config.each do |key, value|
        puts "#{key.upcase}: #{value}"
      end
    end
  end
end
