module SlackPomodoroTimer
  class Timer

    attr_accessor :pomodoros,
                  :interval,
                  :total

    def initialize(options={})
      @pomodoros = options[:pomodoros]
      @interval = options[:interval]
      @stop = false
    end


    # Starts the timer
    # calls the passed block
    # for each pomodoro
    # waiting for the interval (seconds)
    # between calls
    def start(&block)
      @total = @pomodoros
      begin
        yield(@pomodoros)
        sleep(@interval)
        @pomodoros -= 1
        start(&block) unless stop?
      rescue SystemExit, Interrupt
        # rescues interrupt to allow
        # quit with ctrl-c
      end
    end


    # Stops the currently
    # in progress timer
    def stop
      @stop = true
    end


    private

    # Returns true if stopped
    # manually or if no pomodoros
    # left
    def stop?
      if @pomodoros < 0 || @stop
        @pomodoros = @total
        @stop = false
        true
      else
        false
      end
    end


  end
end

