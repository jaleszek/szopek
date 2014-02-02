# missing feature: quantity incrementation

class Cart < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items

  def shipping_cost
    # serious implementation this is out of the scope the task
    10.0
  end

  def items_cost
    Cart::ItemsCostCalculator.new(cart_items).result
  end

  def total_cost
    items_cost + shipping_cost
  end
end
