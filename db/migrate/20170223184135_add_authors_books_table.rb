class AddAuthorsBooksTable < ActiveRecord::Migration[5.0]
  def change
    create_table :authors_books, id: false, force: :cascade do |t|
      t.integer :author_id
      t.integer :book_id
      t.index [:author_id, :book_id], name: :index_authors_books_on_author_id_and_book_id, using: :btree
      t.index [:author_id], name: :index_authors_books_on_author_id, using: :btree
      t.index [:book_id], name: :index_authors_books_on_book_id, using: :btree
    end
  end
end
