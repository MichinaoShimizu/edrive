# edrive

[![Gem Version](https://badge.fury.io/rb/edrive.svg)](https://badge.fury.io/rb/edrive)

Provide simple event dispatcher mechanism for all of ruby products.

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

### Edrive::Dispatcher

main class

#### lambda & dispatch

```ruby
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event, -> { puts 1 })
dispatcher.subscribe(:event, -> { puts 2 })
dispatcher.subscribe(:event, -> { puts 3 })
dispatcher.dispatch(:event)

1
2
3
```

#### lambda & dispatch with data

```ruby
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event, ->(data) { data + 1 })
dispatcher.subscribe(:event, ->(data) { data + 2 })
dispatcher.subscribe(:event, ->(data) { data + 3 })
dispatcher.subscribe(:event, ->(data) { puts data })
dispatcher.dispatch_with_data(:event, 100)

106
```

#### block

```ruby
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event) { puts 1 }
dispatcher.subscribe(:event) { puts 2 }
dispatcher.subscribe(:event) { puts 3 }
dispatcher.dispatch(:event)

1
2
3
```

#### block & dispatch with data

```ruby
dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:event) { |data| data + 1 }
dispatcher.subscribe(:event) { |data| data + 2 }
dispatcher.subscribe(:event) { |data| data + 3 }
dispatcher.dispatch_with_data(:event, 100)

106
```

### clear target event

```ruby
dispatcher.clear!(:event)
```

### clear all event

```ruby
dispatcher.clear_all!
```

### Edrive::ProcessorDispatcher

Event dispatcher for processor class inherited `Edrive::Dispatcher`.

Use `:before_process`, `:after_process` events only in this class.

This class has `dispatch_all` method.

```ruby
  def dispatch_all(use_result = true)
    dispatch(DEFINED_EVENT[0])
    if use_result
      result = dispatch_processor_process
      return dispatch_with_data(DEFINED_EVENT[1], result)
    end
    dispatch_processor_process
    dispatch(DEFINED_EVENT[1])
  end
```

### Edrive::Handler

sample event handlers class.

```ruuby
require 'edrive'

dispatcher = Edrive::Dispatcher.new
dispatcher.subscribe(:before, Edrive::Handler.hash2json)
dispatcher.subscribe(:before, Edrive::Handler.json2hash)
puts dispatcher.dispatch_with_data(:before, hoge: 2, fuga: 3)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/edrive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Edrive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/edrive/blob/master/CODE_OF_CONDUCT.md).
