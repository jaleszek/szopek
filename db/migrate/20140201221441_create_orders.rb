class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status, null: false
      t.integer :cart_id, null: false
    end

    add_index :orders, :cart_id, unique: true
  end
end
