require 'spec_helper'
require 'slack_pomodoro_timer/timer'

describe SlackPomodoroTimer::Timer do

  let(:timer) { SlackPomodoroTimer::Timer.new }


  before do
    timer.pomodoros = 1
    timer.interval = 1
    allow(timer).to receive(:puts)
    allow(timer).to receive(:print)
  end


  describe '#start' do

    before do
      allow(timer).to receive(:sleep)
    end


    it 'runs a block on timer start' do
      expect { |b| timer.start(&b) }.to yield_successive_args(1, SlackPomodoroTimer::Timer::DONE)
    end
  end


  describe '#stop?' do

    before do
      allow(timer).to receive(:sleep)
    end


    it 'returns false when the timer has pomodoros' do
      expect(timer.send(:stop?)).to eq(false)
    end


    it 'returns true when pomodoros are less than 0' do
      timer.pomodoros = -1
      expect(timer.send(:stop?)).to eq(true)
    end
  end

end

