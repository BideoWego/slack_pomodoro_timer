module SlackPomodoroTimer
  class Timer

    attr_accessor :pomodoros,
                  :interval

    attr_reader :total


    # Accepts options for pomodoros
    # and a time interval in seconds
    def initialize(options={})
      @pomodoros = options[:pomodoros]
      @interval = options[:interval]
      @total = options[:pomodoros]
    end

    # Starts the timer
    # calls the passed block
    # for each pomodoro
    # displays countdown until next interval
    def start(&block)
      puts start_message if @pomodoros == @total
      begin
        yield(current_pomodoro) if block_given?
        display_countdown
        @pomodoros -= 1
        start(&block) unless stop?
      rescue SystemExit, Interrupt
        puts quit_message
      end
    end


    # Sets the number of pomodoros
    # and the resets total
    def pomodoros=(pomodoros)
      @total = pomodoros
      @pomodoros = pomodoros
    end




    private

    # Displays the timer countdown to next
    # pomodoro in the console
    def display_countdown
      end_time = Time.now + @interval
      until Time.now > end_time
        print "#{time_remaining(end_time)}\r"
        sleep 1
      end
      puts "#{pomodoro_status} -- POSTED at #{current_time}"
    end


    # Returns the time remaining until
    # the next timer fire
    def time_remaining(end_time)
      remaining = (end_time - Time.now).ceil
      format_countdown(remaining)
    end


    # Formats the countdown timer
    # to display like a digital clock
    # and returns the string
    def format_countdown(seconds)
      minutes = (seconds / 60).to_s.rjust(2,"0")
      while seconds >= 60
        seconds -= 60
      end
      seconds = seconds.to_s.rjust(2,"0")

      "#{pomodoro_status} -- #{minutes}:#{seconds}"
    end


    # Get the current time
    # formatted as an AM/PM digital clock
    def current_time
      Time.now.strftime("%l:%M %p")
    end


    # Returns the timer start message
    def start_message
      "Slack Pomodoro Timer started!" +
      "\nStop the timer at any time with CTRL-C"
    end


    # Returns the timer quit message
    def quit_message
      "\nRemaining pomodoros will not be posted." +
      "\nQuitting slack_pomodoro_timer..."
    end


    # Returns the number of the
    # current pomodoro fired in the total
    def pomodoro_status
      "Pomodoro #{current_pomodoro} of #{total}"
    end


    # Returns the number of the current
    # pomodoro in ascending increments
    def current_pomodoro
      total - pomodoros + 1
    end

    # Returns true if stopped
    # manually or if no pomodoros
    # left
    def stop?
      if @pomodoros <= 0
        @pomodoros = total
        true
      else
        false
      end
    end


  end
end
