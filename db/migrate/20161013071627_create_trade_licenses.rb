class CreateTradeLicenses < ActiveRecord::Migration
  def change
    create_table :trade_licenses do |t|
      t.integer :fiscal_year
      t.integer :license_fee
      t.references :trade_organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
