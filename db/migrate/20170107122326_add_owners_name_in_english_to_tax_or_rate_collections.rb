class AddOwnersNameInEnglishToTaxOrRateCollections < ActiveRecord::Migration
  def change
    add_column :tax_or_rate_collections, :owners_name_in_english, :string
  end
end
