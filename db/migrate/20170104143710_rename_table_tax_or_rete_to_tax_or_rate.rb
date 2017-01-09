class RenameTableTaxOrReteToTaxOrRate < ActiveRecord::Migration
  def change
    rename_table :tax_or_rete_collections, :tax_or_rate_collections if ActiveRecord::Base.connection.table_exists? 'tax_or_rete_collections'
  end
end
