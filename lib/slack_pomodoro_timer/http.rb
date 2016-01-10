require 'net/http'
require 'json'

module SlackPomodoroTimer
  class HTTP
    REGEXES = {
      :slackbot => /\.slack.com\/services\/hooks\/slackbot/,
      :webhook => /hooks\.slack\.com\/services/
    }


    attr_accessor :url,
                  :data,
                  :response

    attr_reader :integration_type


    def initialize(options={})
      @url = options[:url]
      @data = options[:data]
      set_integration_type
    end

    # Overrides default setter
    # to allow internally
    # setting the integration type
    # based on the URL
    def url=(value)
      @url = value
      set_integration_type
      @url
    end


    # Posts the data to the given URL
    def post
      data = serialized_data
      url = url_for_integration_type
      @response = Net::HTTP.post_form(URI.parse(url), data)
    end

    private
    # Returns a hash with a payload key
    # conforming to what Net::HTTP expects
    # in it's data parameter
    def serialized_data
      {
        :payload => serialize_data_by_integration_type
      }
    end


    # Returns the data format that
    # Slack expects for the
    # integration type
    # See:
    #   https://api.slack.com/slackbot
    #   https://api.slack.com/incoming-webhooks
    def serialize_data_by_integration_type
      if @integration_type == 'slackbot'
        serialize_slackbot_data
      else
        serialize_webhook_data
      end
    end


    # Returns only the text
    # of the original data
    # as explain here
    #   https://api.slack.com/slackbot
    # Slack expects only the raw text
    # for this integration type
    def serialize_slackbot_data
      @data[:text]
    end


    # Returns the original data
    # serialized into JSON
    def serialize_webhook_data
      @data.to_json
    end


    # Returns the appropriate
    # URL for the integration type
    def url_for_integration_type
      if @integration_type == 'slackbot'
        url = @url
        url += "&channel=#{URI.encode(@data[:channel])}"
      end
    end


    # Sets the integration type
    # based on the format of the URL
    def set_integration_type
      if @url.match(REGEXES[:slackbot])
        @integration_type = 'slackbot'
      elsif @url.match(REGEXES[:webhook])
        @integration_type = 'webhook'
      else
        raise ArgumentError, "Slack URL is invalid"
      end
    end


  end
end

