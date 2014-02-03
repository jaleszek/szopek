module Payments
  class ParamsBuilder

    attr_reader :order, :method

    def initialize(order, method)
      @order  = order
      @method = method
    end

    def build
      {
        accept_url: '/payment/success',
        amount: order.total_cost,
        backurl: '',
        exception_url: '/payment/failure',
        language: I18n.locale,
        orderid: order.id,
        pm: method.value
      }
    end
  end
end
