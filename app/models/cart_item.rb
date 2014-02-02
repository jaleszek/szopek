class CartItem < ActiveRecord::Base
  validates :cart_id, presence: true, uniqueness: { scope: :item_id }
  validates :item_id, presence: true
  validates :quantity, presence: true

  belongs_to :cart, dependent: :destroy
  belongs_to :item, dependent: :destroy

  delegate :name, :price, to: :item
end
