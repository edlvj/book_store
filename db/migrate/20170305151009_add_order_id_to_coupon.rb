class AddOrderIdToCoupon < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :order_id, :string
    add_index :coupons, [:order_id], name: :index_coupons_on_order_id, using: :btree
  end
end
