require 'spec_helper'

describe Payments::Response do
  subject{ described_class.new(input) }

  let(:input){
    {
      "orderID"=>"8",
      "PAYID"=>"769159873",
      "NCSTATUS"=>"0",
      "NCERROR"=>"0",
      "ACCEPTANCE"=>"057881",
      "STATUS"=>"7",
      "amount"=>"155.9",
      "currency"=>"CHF",
      "PM"=>"Crx``editCard",
      "BRAND"=>"Visa",
      "SHA1" => "ce7d0909f1772e84beb60284e25c11a1e7"
    }
  }

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
