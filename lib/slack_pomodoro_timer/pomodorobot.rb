module SlackPomodoroTimer
  class Pomodorobot

    # Start a new timer
    # with the given number of pomodoroes
    # that fires at the given interval in seconds
    def self.start_timer(pomodoros, interval_in_seconds)
      Config.load
      timer = Timer.new(pomodoros: pomodoros.to_i, interval: interval_in_seconds)
      timer.start do |current_pomodoro|
        message = '@group :pomodoro:'
        if current_pomodoro == timer.total
          message += ' Last one!'
        elsif current_pomodoro == Timer::DONE
          message += "s are DONE!"
        end
        post message
      end
    end


    private

    # Post the given text message to slack
    def self.post(text)
      http = HTTP.new(url: Config.get(:url))
      data = {
        channel: "##{Config.get(:channel)}",
        text: text
      }
      http.data = data
      http.post
    end


  end
end
