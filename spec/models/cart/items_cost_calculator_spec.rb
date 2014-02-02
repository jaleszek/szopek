require 'spec_helper'

describe Cart::ItemsCostCalculator do
  subject { described_class.new(items) }

  let(:items) do
    [
      double(price: 5.5, quantity: 2),
      double(price: 100, quantity: 1)
    ]
  end

  describe '#result' do
    it 'sums multiplied costs of each item' do
      expect(subject.result).to eq(111)
    end
  end

  describe '.new' do
    it 'assigns input to @items instance variable' do
      expect(subject.instance_variable_get('@items')).to eq(items)
    end
  end
end
