module Edrive
  # Simple Event Dispatcher
  # @author Michinao Shimizu <shimizu.michinao@gmail.com>
  class Dispatcher
    attr_accessor :event_listeners

    # initialize
    def initialize
      @event_listeners = {}
    end

    # Subscribe with proc, lambda
    # @param [Symbol] event event name symbol
    # @param [Proc] subscriber subscriber
    # @raise ArgumentError
    # @return [Array] registered subscriber list
    def subscribe(event, subscriber)
      raise ArgumentError, 'subscriber must be Proc object' unless subscriber.is_a?(Proc)
      regist_subscriber_proc(event, subscriber)
    end

    # Subscribe with block
    # @param [Symbol] event event name symbol
    # @param [Block] subscriber subscriber
    # @return [Array] registered subscriber list
    def subscribe_block(event, &subscriber)
      regist_subscriber_proc(event, subscriber)
    end

    # Dispatch specific event subscribers
    # @param [Symbol] event event name
    # @param [Mixed] args
    # @return [Mixed] last subscriber return value
    def dispatch(event, *args)
      result = nil

      @event_listeners[event]&.each do |subscriber|
        result = subscriber.call(*args)
      end
      result
    end

    # Dispatch specific event subscribers with data
    # @param [Symbol] event event name
    # @param [Mixed] args
    # @return [Mixed] last subscriber return value
    def dispatch_with_data(event, data, *args)
      result = data.dup
      @event_listeners[event]&.each do |subscriber|
        result = subscriber.call(result, *args)
      end
      result
    end

    # Get specific event subscribers
    # @param [Symbol] event event name symbol
    # @return [Array] registered subscriber list
    def subscribers(event)
      @event_listeners[event] || []
    end

    # Clear specific event subscribers
    # @param [Symbol] event event name symbol
    # @return [Array] emnpty array
    def clear_subscribers!(event)
      @event_listeners[event] = []
    end

    # Clear all of event subscribers
    # @return [Hash] emnpty hash
    def clear_all_subscribers!
      @event_listeners = {}
    end

    private

    # Regist subscriber proc
    # @param [Symbol] event event name symbol
    # @param [Proc] subscriber subscriber
    # @return [Array] registered subscriber list
    def regist_subscriber_proc(event, subscriber)
      @event_listeners[event] ||= []
      @event_listeners[event] << subscriber
    end
  end
end
