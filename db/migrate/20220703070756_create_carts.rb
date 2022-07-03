class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price
      t.decimal :subtotal
      t.decimal :discount

      t.timestamps
    end
  end
end
