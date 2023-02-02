class ChangeDateColumnNameBooks < ActiveRecord::Migration[7.0]
  def change
    rename_column :books, :publishedAt, :published_at
    rename_column :books, :completedAt, :completed_at
  end
end
