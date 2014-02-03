FactoryGirl.define do
  factory :cart_item do
    cart_id 1
    item_id 1
  end

  factory :cart_item_with_price_five, parent: :cart_item do
    item{ |c| c.association(:item_with_price_five) }
  end
end
