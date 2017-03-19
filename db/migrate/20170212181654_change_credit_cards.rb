class ChangeCreditCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :credit_cards, :expiration_year
    remove_column :credit_cards, :expiration_month
    add_column :credit_cards, :expiration_date, :string
  end
end
