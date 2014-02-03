require 'spec_helper'

feature 'order process' do
  let(:user){ create(:user) }
  let(:cart){ create(:cart_with_two_items, user_id: user.id) }

  before do
    stub_request(:post, Settings.payment_endpoint_address)
  end

  scenario 'user sees order payment page and wants to pay' do
    visit new_cart_order_path(cart)

    click_button('Pay now')
    # user is redirected to internal payments service
    # would be nice to have payment gateway test environment available to test entire flow
  end
end
