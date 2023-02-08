class AddAcceptedToRelationship < ActiveRecord::Migration[7.0]
  def change
    add_column :relationships, :accepted, :boolean
  end
end
