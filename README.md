# Edrive

We provide simple event dispatcher mechanism for your ruby products.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'edrive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edrive

## Usage

### subsclibe lambda & dispatch

```
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event, -> { puts 1 })
dispatcher.subscribe(:event, -> { puts 2 })
dispatcher.subscribe(:event, -> { puts 3 })
dispatcher.dispatch(:event)

1
2
3
```

### subsclibe lambda & dispatch with data

```
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event, ->(data) { data + 1 })
dispatcher.subscribe(:event, ->(data) { data + 2 })
dispatcher.subscribe(:event, ->(data) { data + 3 })
dispatcher.subscribe(:event, ->(data) { puts data })
dispatcher.dispatch_with_data(:event, 100)

106
```

### subscribe with block

```
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe_block(:event) { puts 1 }
dispatcher.subscribe_block(:event) { puts 2 }
dispatcher.subscribe_block(:event) { puts 3 }
dispatcher.dispatch(:event)

1
2
3
```

### clear target event

```
dispatcher.clear_subscribers!(:event)
```

### clean all event

```
dispatcher.clear_all_subscribers!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/edrive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Edrive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/edrive/blob/master/CODE_OF_CONDUCT.md).
