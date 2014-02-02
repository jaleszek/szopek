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
  end
end
