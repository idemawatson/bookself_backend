class ChangeDatatypePublishedAtOfBooks < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :publishedAt, :string
  end
end
