class ChangeQuantityInCartItems < ActiveRecord::Migration[6.1]
  def up
    change_column :cart_items, :quantity, :integer, default: 0
    change_column :order_items, :quantity, :integer, default: 0
    change_column :products, :inventory, :integer, default: 0
  end

  def down
    change_column :cart_items, :quantity, :integer, default: nil
    change_column :order_items, :quantity, :integer, default: nil
    change_column :products, :inventory, :integer, default: nil
  end
end
