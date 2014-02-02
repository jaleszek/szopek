# Assumed that after payment processing on the external service redirection from payments goes on :backurl param.
# Further redirection on success/failure is based on response status, :order_payments_url deals with it.

module Payments
  class ParamsBuilder
    include Rails.application.routes.url_helpers

    attr_reader :order, :method

    def initialize(order, method)
      @order  = order
      @method = method
    end

    def build
      {
        :accept_url => '/payment/success',
        :amount => order.total_cost,
        :backurl => order_payments_url(order),
        :exception_url  =>  '/payment/failure',
        :language => I18n.locale,
        :orderid => order.id,
        :pm => method.value
      }
    end
  end
end
