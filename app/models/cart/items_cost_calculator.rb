class Cart::ItemsCostCalculator
  def initialize(items)
    @items = items
  end

  def result
    @items.to_a.sum{ |item| item.price * item.quantity }
  end
end
