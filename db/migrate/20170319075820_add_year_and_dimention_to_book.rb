class AddYearAndDimentionToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :pub_year, :string
    add_column :books, :dimension, :string
  end
end
