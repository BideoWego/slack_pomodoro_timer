require 'spec_helper'
require 'slack_pomodoro_timer/timer'

describe SlackPomodoroTimer::Timer do
  let(:timer) { SlackPomodoroTimer::Timer.new }

  before do
    timer.pomodoros = 1
    timer.interval = 1
  end

  describe '#start' do
    it 'runs a block on timer start' do
      expect { |b| timer.start(&b) }.to yield_successive_args(1, 0)
    end
  end


  describe '#stop' do
    it 'stops the timer from running' do
      timer.pomodoros = 2
      Thread.new do
        timer.start {}
      end
      # The call to timer.stop doesn't
      # affect the outcome of the test
      timer.stop
      expect(timer.pomodoros).to eq(2)
    end
  end


end

