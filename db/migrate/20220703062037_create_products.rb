class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :inventory
      t.boolean :is_available

      t.timestamps
    end
  end
end
