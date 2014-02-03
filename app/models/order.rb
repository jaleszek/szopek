class Order < ActiveRecord::Base
  validates :status, presence: true
  validates :cart_id, presence: true

  belongs_to :cart

  state_machine :status, initial: :open do
    event :mark_as_sent do
      transition open: :sent
    end

    event :mark_as_paid do
      transition sent: :paid
    end

    event :mark_as_failed do
      transition sent: :failed
    end
  end

  def total_cost
    cart.total_cost
  end
end
