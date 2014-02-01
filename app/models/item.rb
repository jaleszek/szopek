class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true

  has_many :cart_items
  has_many :carts, through: :cart_items
end
