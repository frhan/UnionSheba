class RemoveColumnsFromTradeLicense < ActiveRecord::Migration
  def change
    remove_column :trade_licenses,:license_fee
    remove_column :trade_licenses,:remaining_fee
    remove_column :trade_licenses,:fine_fee
    remove_column :trade_licenses,:vat
    remove_column :trade_licenses,:licsense_no
  end
end
