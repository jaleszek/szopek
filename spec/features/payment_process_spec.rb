require 'spec_helper'

feature 'the ordering process' do
  before { load("#{Rails.root}/lib/seeds/populate_order_page.rb") }

  before do
    stub_request(:post, Settings.payment_endpoint_address)
  end

  let(:cart) { Cart.last }

  scenario 'successful payment' do

    visit new_cart_order_path(cart)
    click_button('Pay now')
  end
end
