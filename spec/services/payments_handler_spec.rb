describe PaymentsHandler do
  subject{ described_class.new(params) }
  let(:params){ { } }
  let(:order){ double }
  before{ allow_any_instance_of(Payments::ResponseEvaluator).to receive(:order).and_return(order) }

  describe '.new' do
    it 'assigns input to :params' do
      expect(subject.params).to eq(params)
    end
  end

  describe '#perform' do
    before{ allow(subject).to receive(:success?).and_return(success)}

    context 'success' do
      let(:success){ true }

      it 'marks order as paid' do
        expect(order).to receive(:mark_as_paid)
        subject.perform
      end
    end

    context 'failure' do
      let(:success){ false }
      it 'marks order as failed' do
        expect(order).to receive(:mark_as_failed)
        subject.perform
      end
    end
  end

  describe '#success?' do
    it 'delegates resp. to evaluator' do
      expect_any_instance_of(Payments::ResponseEvaluator).to receive(:success?)
      subject.perform
    end
  end
end
