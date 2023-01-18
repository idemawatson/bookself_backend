class ChangeDatatypeSubOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :sub, :string, null: false, unique: true
  end
end
