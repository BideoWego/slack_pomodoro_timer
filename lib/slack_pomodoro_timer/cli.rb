require 'thor'

module SlackPomodoroTimer
  class CLI < Thor
    def hello(message)
      puts message
    end
  end
end

