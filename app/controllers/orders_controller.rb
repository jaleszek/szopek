class OrdersController < ApplicationController

  def new
    @cart = Cart.find_by_user_id(current_buyer.id)
    @payment_methods = Payments::Method.all
  end

  def create
    order = current_cart.build_order

    if order.save
      payment = Payments::Initializer.new(order, params[:payment_method])
      payment.run
    end

    redirect_to(payment.redirect_url || new_cart_order_path(current_cart))
  end

  private

  def current_cart
    @current_cart ||= current_buyer.carts.find(params[:cart_id])
  end
end
