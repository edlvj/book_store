class AddConfirmedDateToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :confirmed_date, :date
  end
end
