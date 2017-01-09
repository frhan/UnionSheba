class AddOwnersNameInEnglishToOthersCollections < ActiveRecord::Migration
  def change
    add_column :others_collections, :owners_name_in_english, :string
  end
end
