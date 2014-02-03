FactoryGirl.define do
  sequence(:name) { |n| "Example name#{n}"}

  factory :item do
    name
    price { (rand * 100).to_d }
  end
end
