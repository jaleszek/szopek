# probably could be an ActiveRecord model but because of
# no requirements, left without adding dependencies yet
module Payments
  class Method < Struct.new(:name, :value, :default)
    def self.all
      [
        new('CreditCard', 'visa', true),
        new('PAYPAL', 'paypal', false)
      ]
    end

    def self.find_by_value(value)
      all.find{ |method| method.value == value }
    end
  end
end
