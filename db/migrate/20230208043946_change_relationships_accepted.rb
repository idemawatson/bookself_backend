class ChangeRelationshipsAccepted < ActiveRecord::Migration[7.0]
  def change
    change_column :relationships, :accepted, :boolean, null: false, default: false
  end
end
