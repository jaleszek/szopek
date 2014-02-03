require 'spec_helper'

feature 'order process' do
  let(:user){ create(:user) }
  let(:cart){ create(:cart_with_two_items, user_id: user.id) }

  before do
    stub_request(:post, Settings.payment_endpoint_address)
    allow_any_instance_of(Payments::Initializer).to receive(:run).and_return(true)
    allow_any_instance_of(Payments::Initializer).to receive(:redirect_url).and_return(redirect_url)
  end

  context 'failure' do
    let(:redirect_url) { finish_payments_path }

    scenario 'user receives payment failure' do
      visit new_cart_order_path(cart)
      click_button('Pay now')
      expect(current_path).to eq(failure_payments_path)
    end
  end

  context 'success' do
    let(:redirect_url){ finish_payments_path(FakeResponseBuilder.build_successful(order)) }
    let(:order){ create(:order_sent, cart_id: cart.id) }

    before { allow_any_instance_of(Cart).to receive(:build_order).and_return(order) }

    scenario 'user receives payment success' do
      visit new_cart_order_path(cart)
      click_button('Pay now')
      expect(current_path).to eq(success_payments_path)
    end
  end
end
