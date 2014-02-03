module Payments
  class Initializer
    attr_reader :order, :method

    def initialize(order, method)
      @order = order
      @method = method
    end

    def run
      caller.call
      order.mark_as_sent if caller.accepted?
    end

    delegate :redirect_url, to: :caller

    private

    def caller
      @caller ||= Payments::GatewayCaller.new(params)
    end

    def payment_method
      @payment_method ||= Payments::Method.find_by_value(method)
    end

    def params
      @params ||= Payments::ParamsBuilder.new(order, payment_method).build
    end
  end
end
