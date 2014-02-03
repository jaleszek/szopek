FactoryGirl.define do
  factory :cart do
    user_id 1
  end

  factory :cart_with_two_items, parent: :cart do
    cart_items  do |items|
      [
        items.association(:cart_item_with_price_five),
        items.association(:cart_item_with_price_five)
      ]
    end
  end
end
