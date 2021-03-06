class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total_price
      t.decimal :subtotal
      t.decimal :discount

      t.timestamps
    end
  end
end
