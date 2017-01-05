class AddStatusToTaxOrRateCollections < ActiveRecord::Migration
  def change
    add_column :tax_or_rate_collections, :status, :string,default: :active
  end
end
