require 'spec_helper'

describe Payments::ParamsBuilder do
  subject { described_class.new(order, method) }

  let(:order) { double(total_cost: 10.2, id: 1) }
  let(:method) { Payments::Method.all.first }

  describe '.new' do
    it { expect(subject.order).to eq(order) }
    it { expect(subject.method).to eq(method) }
  end

  describe '#build' do
    context 'dynamically assigned params' do
      it { expect(subject.build[:accept_url]).to be_present }
      it { expect(subject.build[:amount]).to eq(order.total_cost) }
      it { expect(subject.build[:backurl]).to be_present }
      it { expect(subject.build[:orderid]).to eq(order.id) }
      it { expect(subject.build[:pm]).to eq(method.value) }
    end
  end
end
