describe Payments::Method do
  context '.all' do
    subject { described_class }

    it 'returns objects respond to :name' do
      expect(subject.all.first).to respond_to(:name)
    end

    it 'returns objects respond to :value' do
      expect(subject.all.first).to respond_to(:value)
    end

    it 'it returns only one default method' do
      expect(subject.all.select{|method| method.default}.count).to eq(1)
    end
  end
end
