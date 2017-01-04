class CreateTaxOrRateCollections < ActiveRecord::Migration
  def change
    create_table :tax_or_rate_collections do |t|
      t.string :village_name
      t.string :owners_name
      t.string :apprisal_no

      t.timestamps null: false
    end
  end
end
