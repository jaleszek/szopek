describe Payments::ResponseEvaluator do
  subject { described_class.new(response) }
  let(:response) { double(order_id: 1) }

  it 'assigns constructor input to :response' do
    expect(subject.response).to eq(response)
  end

  describe '#order' do
    it 'looks for Order object' do
      expect(Order).to receive(:find_by_id).with(response.order_id)
      subject.order
    end

    it 'caches Order object' do
      expect(Order).to receive(:find_by_id).once.and_return(double)
      2.times { subject.order }
    end
  end

  describe '#succeed?' do
    let(:response){ double(order_id: 1, status: '7', amount: 10.0) }
    let(:order) { double(id: 1, total_cost: 10.0, open?: true)}

    before { allow(subject).to receive(:order).and_return(order)}

    context 'success' do
      it{ expect(subject.succeed?).to eq(true) }
    end

    context 'wrong status' do
      before { allow(response).to receive(:status).and_return('10') }

      it{ expect(subject.succeed?).to eq(false) }
    end

    context 'amount mismatch' do
      before { allow(response).to receive(:amount).and_return(987)}

      it{ expect(subject.succeed?).to eq(false) }
    end

    context 'order already processed' do
      before { allow(order).to receive(:open?).and_return(false)}

      it{ expect(subject.succeed?).to eq(false) }
    end

    context 'missing order record' do
      before { allow(subject).to receive(:order).and_return(nil) }

      it{ expect(subject.succeed?).to eq(false) }
    end
  end
end
