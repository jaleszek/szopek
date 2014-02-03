class OrdersController < ApplicationController

  def new
    @cart = Cart.find_by_user_id(current_buyer.id)
    @payment_methods = Payments::Method.all
  end

  def create
    order = current_cart.orders.build

    if order.save
      payment = Payments::Initializer.new(order, params[:payment_method])
      payment.run

      if redirect = payment.caller.redirect_url
        redirect_to redirect and return
      end
    end

    redirect_to new_cart_order_path(current_cart)
  end

  private

  def current_cart
    @current_cart ||= current_buyer.carts.find(params[:cart_id])
  end
end
