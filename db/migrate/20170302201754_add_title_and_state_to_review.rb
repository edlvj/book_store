class AddTitleAndStateToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :state, :string
  end
end
