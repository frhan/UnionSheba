class AddCommentToWarishRelation < ActiveRecord::Migration
  def change
    add_column :warish_relations, :comment, :string
  end
end
