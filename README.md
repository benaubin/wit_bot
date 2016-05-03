# WitBot

[![GitHub stars](https://img.shields.io/github/stars/penne12/wit_bot.svg?style=flat-square?style=flat-square)](https://github.com/penne12/wit_bot)
![gem version](https://img.shields.io/gem/v/wit_bot.svg?style=flat-square)
![gem rank](https://img.shields.io/gem/rt/wit_bot.svg?style=flat-square)
![gem downloads](https://img.shields.io/gem/dt/wit_bot.svg?style=flat-square)

A better [wit.ai] client for Ruby. Written in Ruby. With an api for creating bots. 

Pretty Awesome™

> **Warning:**
> wit_bot does not currently work with the new stories api. If you have a new app, you WILL see errors.
> I'll be trying to fix this in a week or two.
> Currently, only old apps (those that still use intents and entities) are supported, and if they break, that is a bug that should be reported.

## We're on:

| [Product Hunt] | [Hacker News] | [Reddit] |
|----------------|---------------|----------|

[Product Hunt]: https://www.producthunt.com/tech/witbot
[Hacker News]: https://news.ycombinator.com/item?id=11411364
[Reddit]: https://www.reddit.com/r/languagetechnology

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wit_bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wit_bot

## Usage

Usage information is on the [wiki].

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` or `bin/wit` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/penne12/wit_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License].

[wit.ai]: https://wit.ai/
[wiki]: https://github.com/penne12/wit_bot/wiki
[MIT License]: http://opensource.org/licenses/MIT
