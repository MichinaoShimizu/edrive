module Edrive
  # Simple Event Dispatcher
  # @author Michinao Shimizu <shimizu.michinao@gmail.com>
  class Dispatcher
    # initialize
    def initialize
      @events = {}
    end

    # subscribe handler (proc, lambda, block)
    # @param [Symbol] event event name symbol
    # @param [Proc] handler handler (lambda, proc)
    # @param [Block] block handler (block)
    # @raise ArgumentError
    # @return [Array] registered handler list
    def subscribe(event, handler = nil, &block)
      hdl = block_given? ? block : handler
      raise ArgumentError, 'handler must be proc object.' unless hdl.is_a?(Proc)
      regist(event, hdl)
    end

    # dispatch specific event handler
    # @param [Symbol] event event name
    # @param [Mixed] args
    # @return [Mixed] last handler return value
    def dispatch(event, *args)
      result = nil
      @events[event]&.each { |hdl| result = hdl.call(*args) }
      result
    end

    # multiple dispatch
    # @param [Integer] loop_num loop num
    # @param [Symbol] event event name
    # @param [Mixed] *args
    # @return [Mixed] last handler return value
    def multi_dispatch(loop_num, event, *args)
      raise ArgumentError, 'loop_num must be integer.' unless loop_num.is_a?(Integer)
      result = nil
      loop_num.times { result = dispatch(event, *args) }
      result
    end

    # dispatch specific event handlers with data
    # @param [Symbol] event event name
    # @param [Mixed] data initial value
    # @param [Mixed] args
    # @return [Mixed] last handler return value
    def dispatch_with_data(event, data, *args)
      result = data.dup
      @events[event]&.each { |hdl| result = hdl.call(result, *args) }
      result
    end

    # multiple dispatch with data
    # @param [integer] loop_num loop_num
    # @param [Symbol] event event name
    # @param [Mixed] data  initial value
    # @param [Mixed] *args
    # @return [Mixed] last handler return value
    def multi_dispatch_with_data(loop_num, event, data, *args)
      raise ArgumentError, 'loop_num must be integer.' unless loop_num.is_a?(Integer)
      result = data.dup
      loop_num.times { result = dispatch_with_data(event, result, *args) }
      result
    end

    # get event handlers
    # @param [Symbol] event event name symbol
    # @return [Array] registered handler list
    def handlers(event)
      @events[event] || []
    end

    # clear event handlers
    # @param [Symbol] event event name symbol
    # @return [Array] emnpty array
    def clear!(event)
      @events[event] = []
    end

    # clear all of event handlers
    # @return [Hash] emnpty hash
    def clear_all!
      @events = {}
    end

    private

    # regist hanlder to target event
    # @param [Symbol] event event name symbol
    # @param [Proc] handler handler
    # @return [Array] registered handler list
    def regist(event, handler)
      @events[event] ||= []
      @events[event] << handler
    end
  end
end
