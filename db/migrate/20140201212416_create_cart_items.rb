class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, null: false
      t.integer :item_id, null: false
      t.integer :quantity, null: false, default: 1
    end

    add_index :cart_items, [:cart_id, :item_id], unique: true
  end
end
