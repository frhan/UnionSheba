class AddTaxCategoryToTaxOrRateCollections < ActiveRecord::Migration
  def change
    add_reference :tax_or_rate_collections, :tax_category, index: true, foreign_key: true
  end
end
