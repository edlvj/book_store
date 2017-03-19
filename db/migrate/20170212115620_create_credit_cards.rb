class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :number
      t.string :cvv
      t.string :expiration_year
      t.string :expiration_month
      t.integer :user_id
      t.integer :order_id
    
      t.timestamps
    end
    
    add_index :credit_cards, [:order_id], name: :index_credit_carts_on_order_id
    add_index :credit_cards, [:user_id], name: :index_credit_carts_on_user_id
  end
end
