describe Payments::GatewayCaller do

  subject { described_class.new(parameters) }
  let(:status) { 302 }
  let(:parameters) { {} }

  describe '.new' do
    it 'assigns parameters to :input' do
      expect(subject.input).to eq(parameters)
    end
  end

  describe '#call' do
    before{ stub_request(:post, Settings.payment_endpoint_address) }

    it 'sends POST to payments with given parameters' do
      subject.call
      a_request(:post, Settings.payment_endpoint_address).
      with(:body => parameters.to_param).should have_been_made.once
    end

    context 'success' do
      let(:response) { double }
      before { allow(Net::HTTP).to receive(:post_form).and_return(response)}

      it 'assigns response as :response' do
        subject.call
        expect(subject.response).to eq(response)
      end
    end

    context 'in case of exceptions' do
      before { allow(Net::HTTP).to receive(:post_form).and_raise(Net::HTTPHeaderSyntaxError) }

      it 'cathes exception and sets response as nil' do
        subject.call
        expect(subject.response).to eq(nil)
      end
    end
  end
end
