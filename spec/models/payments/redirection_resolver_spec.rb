describe Payments::RedirectionResolver do
  subject { described_class.new(response) }

  let(:response) { double(code: status, header: {'Location' => location} ) }
  let(:location) { 'http://localhost:3000' }
  let(:status)   { '302' }

  it 'assigns constructor input to :response' do
    expect(subject.response).to eq(response)
  end

  describe '#redirect_url' do
    context 'success' do
      it 'retrieves location from header' do
        expect(subject.redirect_url).to eq(location)
      end
    end

    context 'failure response' do
      let(:status) { 500 }

      it 'returns nil' do
        expect(subject.redirect_url).to eq(nil)
      end
    end

    context 'nil input' do
      let(:response) { nil }
      it 'returns nil' do
        expect(subject.redirect_url).to eq(nil)
      end
    end
  end
end
