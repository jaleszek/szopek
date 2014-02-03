FactoryGirl.define do
  sequence(:name) { |n| "Example name#{n}"}

  factory :item do
    name
    price { (rand * 100).to_d }
  end

  factory :item_with_price_five, parent: :item do
    price 5.0
  end
end
