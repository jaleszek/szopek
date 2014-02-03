class CartItem < ActiveRecord::Base
  validates :cart_id, presence: true, uniqueness: { scope: :item_id }
  validates :item_id, presence: true
  validates :quantity, presence: true

  belongs_to :cart
  belongs_to :item

  def unit_price
    item.price
  end

  def price
    unit_price * quantity
  end

  delegate :name, to: :item
end
