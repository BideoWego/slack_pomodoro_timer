require 'spec_helper'
require 'slack_pomodoro_timer/timer'

describe SlackPomodoroTimer::Timer do

  let(:timer) { SlackPomodoroTimer::Timer.new }


  before do
    timer.pomodoros = 1
    timer.interval = 1
  end


  describe '#start' do

    before do
      allow(timer).to receive(:sleep)
    end


    it 'runs a block on timer start' do
      expect { |b| timer.start(&b) }.to yield_successive_args(1, 0)
    end
  end


  describe '#stop?' do
    
    before do
      allow(timer).to receive(:sleep)
    end


    it 'returns false when the timer has pomodoros' do
      expect(timer.send(:stop?)).to eq(false)
    end


    it 'returns true after timer#stop is called and pomodoros are ignored' do
      timer.stop
      expect(timer.send(:stop?)).to eq(true)
    end


    it 'returns true when pomodoros are less than 0' do
      timer.pomodoros = -1
      expect(timer.send(:stop?)).to eq(true)
    end
  end


  describe '#stop' do
    it 'stops the timer from running the next loop' do
      expect(timer).to receive(:sleep).exactly(1).times
      timer.pomodoros = 2
      timer.stop
      timer.start {}
    end
  end


end

