class RenameTypeInAdress < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :type
    add_column :addresses, :addressable_type, :string
  end
end
