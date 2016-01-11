require 'thor'


module SlackPomodoroTimer
  class CLI < Thor

    desc 'config [OPTIONS]', 'set the url and channel options with this command'


    long_desc %Q;
      'config' is essential for Slack Pomodoro Timer to run


      'config --url'


        You must set a URL for the HTTP service to target.
        It is recommended that you use the Slackbot integration URL for this.
        
        For full instructions for how to set this up (you may already have one)
        see the README on the main repository here:


        https://github.com/BideoWego/slack_pomodoro_timer


        Once you have the URL you may pass it to the config command like so:

        $ slack_pomodoro_timer config --url https://company.slack.com/services/hooks/slackbot?token=YOUR_TOKEN_HERE


      'config --channel'


        Setting a channel is optional, however if you do not wish to post
        to the default channel (general) then you will have to set it here.


        To set the channel you may pass it to the config command like so:

        $ slack_pomodoro_timer config --channel fox29actionnews

    ;


    option :url, aliases: :u
    option :channel, aliases: :c


    # Configure the timer URL and channel
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

    long_desc %Q;
      'start' is the command that begins the timer and posts to Slack.


      Pomodoros


        By default, Slack Pomodoro Timer is set to post 1 pomdoro and has a time of 25 minutes.
        
        To add more pomdoros simply specify how many pomodoros you'd like to post like so:

      $ slack_pomodoro_timer start 5


      'start --minutes'

        The time limit defaults to 25 minutes.

        Optionally you can provide a time limit in minutes. This will be display to you as the timer
        counts down to zero, at which time the timer will fire again posting another pomodoro.

        Pass a custom time limit to Slack Pomodoro Timer like so:

        $ slack_pomodoro_timer start --minutes 10


      Stopping the timer

        At any given time while the timer is running you may stop the timer with CTRL-C.


      QUICK TIP!

        To test the timer out try passing it a short time limit like 0.1

        $ slack_pomodoro_timer start --minutes 0.1
        
    ;


    option :minutes, aliases: :m, type: :numeric, default: 25


    # Start a timer with a number of pomodoros
    # and optional time limit in minutes
    def start(pomodoros=1)
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

