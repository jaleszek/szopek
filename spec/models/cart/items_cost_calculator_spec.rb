require 'spec_helper'

describe Cart::ItemsCostCalculator do
  subject { described_class.new(items) }

  let(:items) do
    [
      double(price: 5.5),
      double(price: 100)
    ]
  end

  describe '#result' do
    it 'returns sum of items costs' do
      expect(subject.result).to eq(105.5)
    end
  end

  describe '.new' do
    it 'assigns input to @items instance variable' do
      expect(subject.instance_variable_get('@items')).to eq(items)
    end
  end
end
