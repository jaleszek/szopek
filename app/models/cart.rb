class Cart < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items
end
