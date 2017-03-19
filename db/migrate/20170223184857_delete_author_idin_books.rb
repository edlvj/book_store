class DeleteAuthorIdinBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :author_id
  end
end
