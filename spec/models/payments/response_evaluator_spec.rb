describe Payments::ResponseEvaluator do
  subject{ described_class.new(response) }
  let(:response){ double(order_id: 1) }

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
      2.times{ subject.order }
    end
  end

  describe '#success?' do
    let(:status){ '7' }
    let(:amount){ 10.0 }
    let(:order_open){ true }
    let(:response){ double(order_id: 1, status: status, amount: amount) }
    let(:order){ double(id: 1, total_cost: 10.0, open?: order_open) }

    before{ allow(subject).to receive(:order).and_return(order) }

    context 'accepted' do
      it{ expect(subject.success?).to eq(true) }
    end

    context 'wrong status' do
      let(:status) { '10' }
      it{ expect(subject.success?).to eq(false) }
    end

    context 'amount mismatch' do
      let(:amount) { 1000 }
      it{ expect(subject.success?).to eq(false) }
    end

    context 'order already processed' do
      let(:order_open) { false }
      it{ expect(subject.success?).to eq(false) }
    end

    context 'missing order record' do
      before{ allow(subject).to receive(:order).and_return(nil) }
      it{ expect(subject.success?).to eq(false) }
    end
  end
end
