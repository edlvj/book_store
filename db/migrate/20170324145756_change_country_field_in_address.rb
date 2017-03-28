class ChangeCountryFieldInAddress < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :country
    add_column :addresses, :country_id, :integer
  end
end
