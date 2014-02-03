require 'spec_helper'

describe User do
  subject{ described_class.new }

  describe 'associations' do
    it{ expect(subject).to have_many(:carts) }    
  end
end
