class OrdersController < ApplicationController

  def new
    @cart = Cart.find_by_user_id(current_buyer.id)
    @payment_methods = Payments::Method.all
  end
end
