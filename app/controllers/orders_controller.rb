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
      redirection_url = payment.caller.redirect_url

      order.mark_as_sent if redirection_url
    end

    redirection_url ||= new_cart_order_path(current_cart)
    redirect_to redirection_url
  end

  private

  def current_cart
    @current_cart ||= current_buyer.carts.find(params[:cart_id])
  end
end
