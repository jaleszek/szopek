class Order < ActiveRecord::Base
  validates :status, presence: true
  validates :cart_id, presence: true, uniqueness: true

  belongs_to :cart

  state_machine :status, initial: :open do
    event :mark_as_sent do
      transition :open => :sent
    end

    event :mark_as_paid do
      transition :sent => :paid
    end

    event :mark_as_failed do
      transition :sent => :failed
    end
  end

  # case when order is present isn't handled
  def self.create_from_cart(cart)
    create!(cart_id: cart.id)
  end

  def total_cost
    # TODO: implement
  end
end
