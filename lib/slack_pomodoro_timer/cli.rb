require 'thor'


module SlackPomodoroTimer
  class CLI < Thor

    desc 'config [OPTIONS]', 'set the url and channel options with this command'

    option :url, aliases: :u
    option :channel, aliases: :c

    def config
      Config.load

      if options[:url]
        if HTTP.valid_url?(options[:url])
          Config.add(url: options[:url])
        else
          puts "You have not input a valid slack url."
        end
      end

      if options[:channel]
        Config.add(channel: options[:channel])
      end

      Config.save

      puts "Config updated:" if options[:url] || options[:channel]
      Config.display
    end


    desc 'start COUNT [OPTIONS]', 'set the number of pomodoros and time interval here'

    option :minutes, aliases: :m, type: :numeric, default: 25
    
    def start(pomodoros)
      if Config.configured?
        interval_in_seconds = options[:minutes] * 60
        Pomodorobot.start_timer(pomodoros, interval_in_seconds)
      else
        puts "Not Configured."
        puts "Run 'slack_pomodoro_timer help config'"
      end
    end
  end
end

