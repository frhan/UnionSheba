class AddUnionAndStatusToOthersCollections < ActiveRecord::Migration
  def change
    add_reference :others_collections, :union, index: true, foreign_key: true
    add_column :others_collections, :status, :string,default: :active
  end
end
