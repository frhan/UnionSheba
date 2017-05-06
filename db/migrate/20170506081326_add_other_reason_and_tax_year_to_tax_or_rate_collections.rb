class AddOtherReasonAndTaxYearToTaxOrRateCollections < ActiveRecord::Migration
  def change
    add_column :tax_or_rate_collections, :other_reason, :string
    add_column :tax_or_rate_collections, :tax_year, :string
  end
end
