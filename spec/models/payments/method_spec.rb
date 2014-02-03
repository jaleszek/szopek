describe Payments::Method do
  context '.all' do
    subject{ described_class.all }

    it 'returns objects responds to :name' do
      expect(subject.first).to respond_to(:name)
    end

    it 'returns objects responds to :value' do
      expect(subject.first).to respond_to(:value)
    end

    it 'has one default method' do
      expect(subject.select{|method| method.default}.count).to eq(1)
    end
  end
end
