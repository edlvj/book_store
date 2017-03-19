class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 10, scale: 2
      t.integer :user_id
      t.integer :shipping_id
      t.string :aasm_state
      
      t.timestamps
    end
  end
end
