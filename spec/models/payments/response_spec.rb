require 'spec_helper'

describe Payments::Response do
  subject{ described_class.new(input) }

  let(:input){ FakeResponseBuilder.build_successful }

  describe '.new' do
    it 'assigns @input instance variable from argument' do
      expect(subject.instance_variable_get('@input')).to eq(input)
    end

    it 'freezes @input instance variable' do
      expect(subject.instance_variable_get('@input')).to be_frozen
    end
  end

  describe 'input hash mapping' do
    it 'wraps needed to further processing informations with unified methods' do
      res = described_class::METHODS_MAPPING.all? do |hash_key, method_name|
        subject.send(method_name) == input[hash_key]
      end
    end
  end
end
