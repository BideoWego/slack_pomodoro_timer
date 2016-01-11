module SlackPomodoroTimer
  class Pomodorobot
    def self.start_timer(pomodoros, interval_in_seconds)
      Config.load
      timer = Timer.new(pomodoros: pomodoros.to_i, interval: interval_in_seconds)
      timer.start do |current_pomodoro|
        post "@group :pomodoro:"
      end
      post "@group Finished!"
    end

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
