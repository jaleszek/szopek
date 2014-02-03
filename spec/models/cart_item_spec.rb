require 'spec_helper'

describe CartItem do
  subject{ described_class.new }

  describe 'validations' do
    it{ expect(subject).to validate_presence_of(:cart_id) }
    it{ expect(subject).to validate_presence_of(:cart_id) }
    it{ expect(subject).to validate_presence_of(:item_id) }
    it{ expect(subject).to validate_presence_of(:quantity) }
    it{ expect(create(:cart_item)).to validate_uniqueness_of(:cart_id).scoped_to(:item_id) }
  end

  describe 'associations' do
    it{ expect(subject).to belong_to(:cart) }
    it{ expect(subject).to belong_to(:item) }
  end

  context 'initialy' do
    it 'has quantity equals 1' do
      expect(subject.quantity).to eq(1)
    end
  end

  describe '#unit_price' do
    before{ allow(subject).to receive(:item).and_return(double(price: 10.0)) }

    it 'equals price of related item' do
      expect(subject.unit_price).to eq(10.0)
    end
  end

  describe '#price' do
    subject{ build(:cart_item) }
    before{ allow(subject).to receive(:item).and_return(double(price: 10.0)) }

    it 'multiplies quantity and unit price' do
      expect(subject.price).to eq(subject.unit_price*subject.quantity)
    end
  end
end
