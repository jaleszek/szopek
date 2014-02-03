module Payments
  class Initializer
    attr_reader :order, :method

    def initialize(order, method)
      @order = order
      @method = method
    end

    def run
      caller.call
    end

    def caller
      @caller ||= Payments::GatewayCaller.new(params)
    end

    private

    def payment_method
      @payment_method ||= Payments::Method.find_by_value(method)
    end

    def params
      @params ||= Payments::ParamsBuilder.new(order, payment_method).build
    end
  end
end
