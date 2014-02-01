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
end
