class BookAddIndexUserIdBookId < ActiveRecord::Migration[7.0]
  def change
    add_index :books, [:user_id, :book_id], unique: true
  end
end
