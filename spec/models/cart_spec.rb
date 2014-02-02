require 'spec_helper'

describe Cart do
  subject { described_class.new }

  describe 'validations' do
    it{ expect(subject).to validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to have_many(:cart_items) }
    it { expect(subject).to have_many(:items).through(:cart_items) }
  end

  describe '#items_cost' do
    let(:costs_calculator_class) { Cart::ItemsCostCalculator }
    let(:costs_calculator) { double(result: 12345) }

    it 'passes items collection as argument to calculation class' do
      expect(costs_calculator_class).to receive(:new).with(subject.items).and_return(costs_calculator)
      subject.items_cost
    end

    it 'returns result of calculation class' do
      allow_any_instance_of(costs_calculator_class).to receive(:result).and_return(costs_calculator.result)
      expect(subject.items_cost).to eq(costs_calculator.result)
    end
  end

  describe '#total_cost' do
    before do
      allow(subject).to receive(:items_cost).and_return(10)
    end

    it 'sums shipping cost and items cost' do
      expect(subject.total_cost).to eq(subject.items_cost + subject.shipping_cost)
    end
  end

  describe '#shipping_cost' do
    it 'is constant' do
      expect(subject.shipping_cost).to eq(10.0)
    end
  end
end
