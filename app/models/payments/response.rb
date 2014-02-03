module Payments
  class Response
    attr_reader :input

    METHODS_MAPPING = {
      'orderID' => :order_id,
      'STATUS'  => :status,
      'amount'  => :amount,
      'SHA1'    => :checksum
    }

    def initialize(input)
      @input = input.freeze
    end

    METHODS_MAPPING.each do |hash_key, method_name|
      define_method(method_name) do
        input[hash_key]
      end
    end
  end
end
