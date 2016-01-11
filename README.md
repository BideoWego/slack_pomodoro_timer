# SlackPomodoroTimer

by [kitlangton](https://github.com/kitlangton) and [Bideo Wego](https://github.com/BideoWego)



A Ruby powered command line app for sending timed messages to slack channels




## Installation

### Install the gem
```shell
$ gem install slack_pomodoro_timer
```

### Configure your Slackbot URL

Configure the Slackbot URL:

```shell
$ slack_pomodoro_timer config --url https://company.slack.com/services/hooks/slackbot?token=YOUR_TOKEN_HERE
```



#### Not sure where to find your Slackbot URL?

1. Make sure you are signed into your Slack team at [https://slack.com/signin](https://slack.com/signin)

1. Then go to this link [https://slack.com/apps/build](https://slack.com/apps/build)

1. Click on the 'Configure' button in the top right

1. Now choose 'Custom Integrations'

1. Choose 'Slackbot'

1. If you do not have any Slackbot integrations you'll have to create one, otherwise skip this step and the next

1. Click 'Add Configuration' then 'Add Slackbot Configuration'

1. You should see an edit button next to your created integration as a pencil icon, click it!

1. Scroll down to 'Setup Instructions' and copy the full URL that you see under 'Your slackbot URL is:'

1. Now paste that URL into the above command to configure the URL for Slack Pomodoro Timer

1. You should now be able to run `$ slack_pomodoro_timer start 1`! See below for changing the channel.


NOTE: Slack Pomodoro Timer is actually able to accept a Webhook URL as well,
however this functionality is not fully tested at this time.




### Configure the channel

Slack Pomodoro Timer is configured to send messages to the 'general' channel by default.
If you want to send messages to another channel you'll have to configure it will that channel.

Configure the channel into which you would like to post (this defaults to the general channel):

```shell
$ slack_pomodoro_timer config --channel my_channel
```

You do not need to prepend your channel name with a # symbol, but if you absolutely must, then make sure to wrap your channel name in quotes:

```shell
$ slack_pomodoro_timer config --channel "#my_channel"
```



## Usage

To run 5 consecutive 25 minute Pomodoros:

```shell
$ slack_pomodoro_timer start 5
```

Here's how to use a custom pomodoro time length:

```shell
$ slack_pomodoro_timer start 5 --minutes 10
```

For help on command options and usage use the following syntax:

```shell
$ slack_pomodoro_timer help config
$ slack_pomodoro_timer help start
```


Still a work in progress, however there are minimal passing tests.
To run the tests you can simply run `$ rspec` or use Guard with `$ bundle exec guard`.




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).




## Contributing

Bug reports and pull requests are welcome on GitHub [https://github.com/BideoWego/slack_pomodoro_timer](https://github.com/BideoWego/slack_pomodoro_timer)





## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).





