require 'spec_helper'

describe Cart do
  subject { described_class.new }

  describe 'validations' do
    it{ expect(subject).to validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
  end
end
