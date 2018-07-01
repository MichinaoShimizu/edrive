# frozen_string_literal: true

require 'edrive/dispatcher'

# Event Dispatcher For Processors
# @attr [Processor] processor processor object
# @attr [Symbol] processor_process processor main method symbol
# @author shimimi
class ProcessorDispatcher < Edrive::Dispatcher
  attr_accessor :processor, :processor_process

  # @return [Array] defined event symbols
  DEFINED_EVENT = %i[before after].freeze

  # @return [Symbol] default processor process symbol
  DEFAULT_PROCESSOR_PROCESS = :process

  # Initialize
  # @param [Processor] processor processor object
  # @param [Symbol] processor_process processor main method
  def initialize(processor, processor_process = DEFAULT_PROCESSOR_PROCESS)
    super()
    @processor = processor
    @processor_process = processor_process
  end

  # subscribe handler (proc, lambda, block)
  # @param [Symbol] event event name symbol
  # @param [Proc] handler handler (lambda, proc)
  # @param [Block] block handler (block)
  # @raise ArgumentError
  # @return [Array] registered handler list
  def subscribe(event, handler = nil, &block)
    undefined_event_protect(event)
    super
  end

  # Dispatch all events
  # @param [Boolean] use_result use processor process result in after_process event
  # @return [Mixed] last subscriber return value
  def dispatch_all(use_result = true)
    dispatch(DEFINED_EVENT[0])
    if use_result
      result = dispatch_processor_process
      return dispatch_with_data(DEFINED_EVENT[1], result)
    end
    dispatch_processor_process
    dispatch(DEFINED_EVENT[1])
  end

  # Dispach processor process
  # @param [Mixed] args
  # @return [Mixed] processor process return value
  def dispatch_processor_process(*args)
    processor.send(processor_process, *args)
  end

  private

  # Check event is defined or not
  # @param [Symbol] event event name symbol
  # @raise ArgumentError
  def undefined_event_protect(event)
    raise ArgumentError, "event #{event} is not defined." unless DEFINED_EVENT.include?(event)
  end
end
