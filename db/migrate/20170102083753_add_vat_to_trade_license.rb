class AddVatToTradeLicense < ActiveRecord::Migration
  def change
    add_column :trade_licenses, :vat, :decimal
  end
end
