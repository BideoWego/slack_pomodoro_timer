require 'spec_helper'
require 'slack_pomodoro_timer/config'
require 'fileutils'

describe SlackPomodoroTimer::Config do

  let(:config) { SlackPomodoroTimer::Config }
  let(:fake_config_filename) { 'config' }
  let(:fake_config_path) { "#{Dir.pwd}/fixtures/#{fake_config_filename}" }


  before do
    config.save
    config.class_variable_set(:@@config, {})
    stub_const("SlackPomodoroTimer::Config::PATH", fake_config_path)
  end

  after do
    FileUtils.rm_f(config::PATH) if File.exists?(config::PATH)
  end

  describe '#config' do

    it 'returns a hash' do
      expect(config.config).to be_a(Hash)
    end


    context 'no data was loaded' do

      it 'returns an empty hash' do
        expect(config.config).to be_empty
      end
    end


    context 'data was loaded' do

      it 'returns a hash with channel, url, and type keys' do
        config.load
        expect(config.config).to have_key(:channel)
        expect(config.config).to have_key(:url)
      end


      context 'no config file exists' do

        it 'returns config defaults when no values have been added or saved' do
          config.load
          expect(config.config).to eq(config.send(:defaults))
        end
      end


      context 'a config file exists' do

        let(:data) do
          {
            :channel => 'foo',
            :url => 'bar',
          }
        end


        before do
          write_config(fake_config_path, data)
        end


        it 'returns the data from the config file' do
          config.load
          expect(config.config).to eq(data)
        end
      end
    end


  end


  describe '#add' do

    it 'adds a url to the config' do
      config.add(url: "www.slack.com")
      expect(config.config[:url]).to eq("www.slack.com")
    end


    it 'adds a channel to the config' do
      config.add(channel: "test")
      expect(config.config[:channel]).to eq("test")
    end

  end


  describe '#save' do

    it 'results in writing a file to the location of the path' do
      expect(File).to receive(:open).with(config::PATH, 'w+')
      config.save
    end


    context 'data was passed through #add' do

      it 'results in the default data being written to the file' do
        config.load
        config.save
        text = read_config(fake_config_path)
        expect(text).to match(/general/)
      end
    end


    context 'no data was passed through #add' do

      let(:data) do
        {
          :url => 'www.slack.com',
          :channel => 'general',
        }
      end

      it 'results in the default data being written to the file' do
        config.add(data)
        config.save
        text = read_config(fake_config_path)
        expect(text).to match(/www\.slack\.com/)
        expect(text).to match(/general/)
      end
    end

  end


  describe '#load' do

    it 'returns a hash' do
      expect(config.load).to be_a(Hash)
    end


    context 'the config file exists' do

      it 'calls YAML#load_file with path to file' do
        config.save
        expect(YAML).to receive(:load_file).with(config::PATH)
        config.load
      end
    end


    context 'the config file does not exist' do

      it 'does not call YAML#load_file' do
        expect(YAML).to_not receive(:load_file)
        config.load
      end
    end
  end


  describe '#get' do

    it 'returns the value of the config key' do
      config.add(:channel => 'general')
      expect(config.get(:channel)).to eq('general')
    end
  end


  describe '#display' do

    it 'calls puts' do
      expect(config).to receive(:puts).at_least(1).times
      config.display
    end


    context 'config is empty' do

      it 'does not call #each on the config hash' do
        expect(config.config).to_not receive(:each)
        config.display
      end
    end


    context 'config has values' do

      it 'calls #each on the config hash' do
        config.load
        expect(config.config).to receive(:each)
        config.display
      end
    end
  end
end

