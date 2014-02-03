require 'spec_helper'

describe Item do
  subject{ described_class.new }

  describe 'validations' do
    it{ expect(subject).to validate_presence_of(:name) }
    it{ expect(subject).to validate_presence_of(:price) }
  end

  describe 'associations' do
    it{ expect(subject).to have_many(:cart_items) }
    it{ expect(subject).to have_many(:carts).through(:cart_items) }
  end
end
