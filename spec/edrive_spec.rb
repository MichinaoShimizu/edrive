require 'edrive'

RSpec.describe Edrive do
  let(:event) { :test_event }

  describe '#subscribe lambda' do
    subject do
      dispatcher = Edrive::Dispatcher.new
      dispatcher.subscribe(event, handler)
    end

    let(:handler) { -> { 1 } }
    it { is_expected.to eq([handler]) }
  end

  describe '#dispatch' do
    subject do
      dispatcher = Edrive::Dispatcher.new
      dispatcher.subscribe(event, handler)
      dispatcher.dispatch(event)
    end

    let(:handler) { -> { 1 } }
    it { is_expected.to eq(1) }
  end

  describe '#multi_dispatch' do
    subject do
      dispatcher = Edrive::Dispatcher.new
      dispatcher.subscribe(event, handler)
      dispatcher.multi_dispatch(3, event)
    end

    let(:handler) { -> { 1 } }
    it { is_expected.to eq(1) }
  end

  describe '#dispatch_with_data' do
    subject do
      dispatcher = Edrive::Dispatcher.new
      dispatcher.subscribe(event, handler)
      dispatcher.dispatch_with_data(event, 100)
    end

    let(:handler) { ->(data) { data + 1 } }
    it { is_expected.to eq(101) }
  end

  describe '#multi_dispatch_with_data' do
    subject do
      dispatcher = Edrive::Dispatcher.new
      dispatcher.subscribe(event, handler)
      dispatcher.multi_dispatch_with_data(3, event, 100)
    end

    let(:handler) { ->(data) { data + 1 } }
    it { is_expected.to eq(103) }
  end
end
