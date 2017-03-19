class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :phone
      t.integer :country
      t.integer :order_id
      t.integer :user_id 
      t.string :type
    
      t.timestamps
    end
    
    add_index :addresses, [:order_id], name: :index_addresses_on_order_id
    add_index :addresses, [:user_id], name: :index_addresses_on_user_id
  end
end
