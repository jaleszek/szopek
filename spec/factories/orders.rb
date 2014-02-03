FactoryGirl.define do

  factory :order do
    cart_id 1

    factory :order_sent do
      after(:create) { |order, evaluator| order.mark_as_sent }
    end
  end
end
