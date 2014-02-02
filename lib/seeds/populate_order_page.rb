if Item.count == 0
  5.times do |i|
    Item.create!(price: rand(100), name: "item_#{i}")
  end
end

if User.count == 0
  user = User.create!
  cart = user.carts.create!
  cart.items << Item.all
end

