require 'spec_helper'

describe OrdersController do
  before{ load("#{Rails.root}/lib/seeds/populate_order_page.rb") }

  let(:cart){ Cart.last }
  let(:location){ 'http://some_payment_service.com' }

  describe '#create' do
    context 'failure' do
      before do
        stub_request(:any, Settings.payment_endpoint_address).
        to_return(:status => 500)
      end

      it 'redirects to the new order page' do
        post :create, { "payment_method"=>"visa", "cart_id" => cart.id }
        expect(response).to redirect_to(new_cart_order_path(cart))
      end
    end

    context 'success' do
      before do
        stub_request(:any, Settings.payment_endpoint_address).
        to_return(:status => 302, :headers => { 'Location' => location })
      end

      it 'redirects to external service' do
        post :create, { "payment_method"=>"visa", "cart_id" => cart.id }
        expect(response).to redirect_to(location)
      end
    end
  end
end
