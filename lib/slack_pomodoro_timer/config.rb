require 'yaml'

module SlackPomodoroTimer
  class Config

    FILENAME = '.slack_pomodoro_timer'
    PATH = "#{Dir.home}/#{FILENAME}"


    @@config = {}


    # Class variable getter
    # returns a hash of config values
    def self.config
      @@config
    end


    # Add a config option
    # or options
    def self.add(options={})
      add_option(:channel, options[:channel])
      add_option(:url, options[:url])
    end


    # Saves the current config
    # hash as YAML to the
    # path
    def self.save
      File.open(PATH, 'w+') do |f|
        f.write(YAML.dump(config))
      end
    end


    # Loads the config file if it exists
    # or sets default values
    # if the file does not exist
    def self.load
      file_exists = File.exists?(PATH)
      if File.exists?(PATH)
        value = YAML.load_file(PATH)
      else
        value = defaults
      end
      @@config = value
    end


    # Get a config value by key
    def self.get(key)
      config[key]
    end


    # Display all config values
    def self.display
      if config.empty?
        puts "No config values set"
      else
        config.each do |key, value|
          puts "#{key.upcase}: #{value}"
        end
      end
    end




    private

    # Returns the default config values
    def self.defaults
      {
        :channel => 'general',
        :url => '',
      }
    end


    # Sets the key to the given value
    # unless it is nil
    def self.add_option(key, value)
      config[key] = value unless value.nil?
    end


  end
end
