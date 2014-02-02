module Payments
  class ResponseEvaluator
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def succeed?
      succeed_status? && checksum_matches? && order_matches?
    end

    def order
      @order ||= Order.find_by_id(response.order_id)
    end

    private

    def checksum_matches?
      # place implementation of checking checksum for the request
      true
    end

    def order_matches?
      order.present? && not_processed_yet? && amount_matches?
    end

    def succeed_status?
      response.status == '7'
    end

    def amount_matches?
      order.total_cost == response.amount
    end

    def not_processed_yet?
      order.open?
    end
  end
end

# could be added ActiveModel::Validations in further development to provide
# validations and errors to store information about problem
