class CreateShippings < ActiveRecord::Migration[5.0]
  def change
    create_table :shippings do |t|
      t.string :company
      t.decimal :costs, default: 0.0
      t.timestamps
    end
  end
end
