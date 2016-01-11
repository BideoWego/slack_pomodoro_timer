module SlackPomodoroTimer
  class Timer

    attr_accessor :pomodoros,
                  :interval,
                  :total

    attr_reader :total

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
      begin
        yield(current_pomodoro) if block_given?

        display_countdown

        @pomodoros -= 1

        start(&block) unless stop?
      rescue SystemExit, Interrupt
        puts quit_message
      end
    end

    def pomodoros=(pomodoros)
      @total = pomodoros
      @pomodoros = pomodoros
    end

    private

    def display_countdown
      end_time = Time.now + @interval
      until Time.now > end_time
        print "#{time_remaining(end_time)}\r"
        sleep 1
      end
      puts "#{display_pomodoro_status} -- DONE at#{current_time}"
    end

    def time_remaining(end_time)
      remaining = (end_time - Time.now).ceil
      format_countdown(remaining)
    end

    def format_countdown(seconds)
      hours = seconds / 60 / 60
      minutes = (seconds / 60).to_s.rjust(2,"0")
      seconds = seconds.to_s.rjust(2,"0")

      if hours >= 1
        "#{display_pomodoro_status} -- #{hours}:#{minutes}:#{seconds}"
      else
        "#{display_pomodoro_status} -- #{minutes}:#{seconds}"
      end
    end

    def current_time
      Time.now.strftime("%l:%M %p")
    end

    def quit_message
      "\nRemaining pomodoros will not be posted." +
      "\nQuitting slack_pomodoro_timer..."
    end

    def display_pomodoro_status
      "Pomodoro #{current_pomodoro} of #{total}"
    end

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
