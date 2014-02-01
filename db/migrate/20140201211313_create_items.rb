class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :name, null: false
    end
  end
end
