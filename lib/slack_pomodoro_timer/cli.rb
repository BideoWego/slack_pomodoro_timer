require 'thor'

# Proposed command structure:

# Config the timer
# slack_pomodoro_timer config --url SLACK_INTEGRATION_URL_HERE
# slack_pomodoro_timer config --channel CHANNEL_HERE
# slack_pomodoro_timer config --integration_type CHANNEL_HERE

# Running the timer
# slack_pomodoro_timer start --pomodoros 3 --seconds 100
# slack_pomodoro_timer start --pomodoros 3 --minutes 30
# slack_pomodoro_timer start --pomodoros 3 --hours 1
# slack_pomodoro_timer start --pomodoros 3 --minutes 30 --channel #general


module SlackPomodoroTimer
  class CLI < Thor

    desc 'config [OPTIONS]', 'set the url and channel options with this command'
    option :url
    option :channel
    def config

      if options[:url]
        Config.add(url: options[:url])
        puts "URL: #{options[:url]}"
      end

      if options[:channel]
        Config.add(channel: options[:channel])
        puts "CHANNEL: #{options[:channel]}"
      end

      Config.save

      if options.empty?
        Config.display
      end
    end


    desc 'start [OPTIONS]', 'set the number of pomodoros and time interval here'
    option :seconds
    option :minutes
    option :hours
    option :pomodoros
    def start
      # resolve timer interval
      # run timer
    end
  end
end

