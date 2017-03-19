class AddDaysToShippings < ActiveRecord::Migration[5.0]
  def change
    add_column :shippings, :days, :string
  end
end
