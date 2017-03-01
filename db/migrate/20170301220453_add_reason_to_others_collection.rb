class AddReasonToOthersCollection < ActiveRecord::Migration
  def change
    add_column :others_collections, :reason, :string
  end
end
