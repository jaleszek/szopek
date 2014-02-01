require 'spec_helper'

describe CartItem do
  subject { described_class.new }

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:cart_id) }
    it { expect(subject).to validate_presence_of(:cart_id) }
    it { expect(subject).to validate_presence_of(:item_id) }
    it { expect(subject).to validate_presence_of(:quantity) }
    it { expect(create(:cart_item)).to validate_uniqueness_of(:cart_id).scoped_to(:item_id) }
  end

  describe 'associations' do
    it { expect(subject).to belong_to(:cart).dependent(:destroy) }
    it { expect(subject).to belong_to(:item).dependent(:destroy) }
  end

  context 'initialy' do
    it 'has quantity equals 1' do
      expect(subject.quantity).to eq(1)
    end
  end
end
