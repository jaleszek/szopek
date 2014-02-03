describe Payments::Initializer do
  subject { described_class.new(order, method) }

  let(:order) { build(:order) }
  let(:method) { Payments::Method.all.last.value }

  describe '.new' do
    it { expect(subject.order).to eq(order) }
    it { expect(subject.method).to eq(method)}
  end

  describe '#run' do
    let(:caller) { double }

    it 'performs request' do
      allow(subject).to receive(:caller).and_return(caller)
      expect(caller).to receive(:call)
      subject.run
    end
  end

  describe '#caller' do
    let(:caller) { double }

    it 'returns gateway caller instance' do
      allow(Payments::GatewayCaller).to receive(:new).and_return(caller)
      expect(subject.caller).to eq(caller)
    end
  end
end
