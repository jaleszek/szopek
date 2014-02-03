describe Payments::Initializer do
  subject { described_class.new(order, method) }

  let(:order) { build(:order) }
  let(:method) { Payments::Method.all.last.value }

  before{ allow(order).to receive(:cart).and_return(double(total_cost: 10)) }

  describe '.new' do
    it { expect(subject.order).to eq(order) }
    it { expect(subject.method).to eq(method)}
  end

  describe '#run' do
    let(:caller){ double(accepted?: true, call: true) }
    before{ allow(subject).to receive(:caller).and_return(caller) }

    it 'performs request' do
      expect(caller).to receive(:call)
      subject.run
    end

    context 'redirection received' do
      it 'marks order as sent' do
        expect(order).to receive(:mark_as_sent)
        subject.run
      end
    end
  end

  describe '#redirect_url' do
    it 'finds redirection url' do
      redirect_url = 'localhost'
      allow_any_instance_of(Payments::GatewayCaller).to receive(:redirect_url).and_return(redirect_url)
      expect(subject.redirect_url).to eq(redirect_url)
    end
  end
end
