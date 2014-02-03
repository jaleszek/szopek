describe Order do
  subject{ build(:order) }

  it{ expect(subject).to validate_presence_of(:status) }
  it{ expect(subject).to validate_presence_of(:cart_id) }
  it{ expect(subject).to belong_to(:cart) }

  it 'starts from :open status' do
    expect(subject).to be_open
  end

  describe '#mark_as_sent' do
    it 'changes status to :sent' do
      subject.mark_as_sent
      expect(subject).to be_sent
    end
  end

  context 'order sent' do
    before{ subject.mark_as_sent }

    describe '#mark_as_paid' do
      it 'changes status to :paid' do
        subject.mark_as_paid
        expect(subject).to be_paid
      end
    end

    describe '#mark_as_failed' do
      it 'changes status to :failed' do
        subject.mark_as_failed
        expect(subject).to be_failed
      end
    end
  end

  describe 'total_cost' do
    it 'asks cart about' do
      expect(subject.cart).to receive(:total_cost)
      subject.total_cost
    end
  end
end
