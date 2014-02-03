describe Payments::ResponseLog do
  subject{ described_class.new(response) }
  let(:response){ {} }

  describe '.new' do
    it 'assigns argument to :response' do
      expect(subject.response).to eq(response)
    end
  end
end
