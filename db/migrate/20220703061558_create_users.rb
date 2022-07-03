class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :name
      t.string :auth_token

      t.timestamps
    end
  end
end
