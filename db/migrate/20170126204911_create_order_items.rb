class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.decimal :price
      t.integer :qty
      t.integer :order_id
      t.integer :book_id

      t.timestamps
    end
  end
end
