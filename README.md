# WitBot

A better [wit.ai] client for Ruby. Written in Ruby.

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

Start a REPL:

```bash
$ wit
```

or use with STDIO

```bash
$ wit --input --json
```

or use programmatically

1. Configure WitBot with your access token:

```ruby
WitBot.configure do |c|
  c.token = ENV['WIT_AI_TOKEN']
end
```

2. Create a message:

```ruby
message = WitBot.create_message 'This is a cool test'
```

3. And send it:

```ruby
message.send
```

4. Get the outcome:

```ruby
outcome = message.outcome
```

5. Get the intent and the entities:

```ruby
intent = outcome.intent #=> WitBot::WitModel::Intent
entities = outcome.entities #=> {role => #<WitBot::WitModel::Entity>}
```

6. Get the intent name:

```ruby
intent.name #=> "Test"
```

More information on the [GitHub wiki][wiki].

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wit_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[wit.ai]: https://wit.ai/
[wiki]: wiki