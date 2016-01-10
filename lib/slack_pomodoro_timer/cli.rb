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

    option :seconds
    option :minutes
    option :hours
    option :channel
    option :pomodoros

    desc 'config [OPTIONS]', 'set the url, channel, integration_type options with this command'
    def config
      # set default url
      # set default channel
      # set default integration type
    end

    desc 'start [OPTIONS]', 'set the number of pomodoros and time interval here'
    def start
      # resolve timer interval
      # run timer
    end


  end
end

