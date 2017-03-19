class AddCreditCarttoOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :credit_card_id, :string
    add_index :orders, [:credit_card_id], name: :index_orders_on_credit_card_id, using: :btree
  end
end
