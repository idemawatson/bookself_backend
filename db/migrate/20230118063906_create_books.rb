class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string    :book_id, null: false
      t.string    :title, null: false
      t.string    :author
      t.string    :image_url
      t.text      :comment
      t.string    :description
      t.boolean   :completed
      t.integer   :page_count
      t.date      :publishedAt
      t.datetime  :completedAt
      t.timestamps
      t.references :user, foreign_key: true, null: false
    end
  end
end
