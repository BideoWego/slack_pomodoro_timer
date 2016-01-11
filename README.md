# SlackPomodoroTimer

by [kitlangton](https://github.com/kitlangton) and [Bideo Wego](https://github.com/BideoWego)

A Ruby powered command line app for sending timed messages to slack channels

## Installation

    $ gem install slack_pomodoro_timer

Configure your Slackbot url:

    $ slack_pomodoro_timer config --url https://company.slack.com/services/hooks/slackbot?token=thisisyourtoken

Configure the channel into which you would like to post (this defaults to the general channel):

    $ slack_pomodoro_timer config --channel my_channel

You do not need to prepend your channel name with a # symbol, but if absolutely must, then make sure to wrap your channel name in quotes:

    $ slack_pomodoro_timer config --channel "#my_channel"

## Usage

To run 5 consecutive 25 minute Pomodoros:

    $ slack_pomodoro_timer start 5

Here's how to use a custom pomodoro length:

    $ slack_pomodoro_timer start 5 --minutes 10

Still a work in progress, however there are minimal passing tests.
To run the tests you can simply run `$ rspec` or use Guard with `$ bundle exec guard`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/slack_pomodoro_timer.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

