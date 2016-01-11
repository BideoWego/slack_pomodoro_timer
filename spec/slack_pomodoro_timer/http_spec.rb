require 'spec_helper'
require 'slack_pomodoro_timer/http'

describe SlackPomodoroTimer::HTTP do

  let(:url) { 'https://vikingcodeschool.slack.com/services/hooks/slackbot?token=bii9bJoHe1mbns9bBm5lTpb6' }
  let(:http) { SlackPomodoroTimer::HTTP.new(:url => url) }
  let(:valid_data) do
    {
      :channel => '#test',
      :username => 'slackbot',
      :text => 'Hello there!'
    }
  end

  describe '#post' do
    it 'returns response with status code of 200 when url and data are valid' do
      http.data = valid_data
      http.post
      expect(http.response.code.to_i).to eq(200)
    end
  end


  describe '#valid_url?' do
    it 'returns true if the url is valid' do
      expect(SlackPomodoroTimer::HTTP.valid_url?(url)).to eq true
    end

    it 'returns false if the url is not a slack url' do
      expect(SlackPomodoroTimer::HTTP.valid_url?('www.google.com')).to eq false
    end

    it 'returns false if the url is empty' do
      expect(SlackPomodoroTimer::HTTP.valid_url?('')).to eq false
    end
  end

end


