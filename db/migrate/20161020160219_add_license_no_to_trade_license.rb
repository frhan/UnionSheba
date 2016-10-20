class AddLicenseNoToTradeLicense < ActiveRecord::Migration
  def change
    add_column :trade_licenses, :licsense_no, :string
    add_column :trade_licenses, :issur_date, :date
  end
end
