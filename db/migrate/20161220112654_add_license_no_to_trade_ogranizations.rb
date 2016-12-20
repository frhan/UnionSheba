class AddLicenseNoToTradeOgranizations < ActiveRecord::Migration
  def change
    add_column :trade_organizations, :license_no, :string
  end
end
