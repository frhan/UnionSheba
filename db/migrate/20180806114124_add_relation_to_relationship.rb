class AddRelationToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :relation, :string
    add_column :relationships, :lang, :string
  end
end
