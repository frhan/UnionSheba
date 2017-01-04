class AddUnionsToTaxOrRateCollections < ActiveRecord::Migration
  def change
    add_reference :tax_or_rate_collections, :union, index: true, foreign_key: true
  end
end
