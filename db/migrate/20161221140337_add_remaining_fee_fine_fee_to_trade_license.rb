class AddRemainingFeeFineFeeToTradeLicense < ActiveRecord::Migration
  def change
    add_column :trade_licenses, :remaining_fee, :integer
    add_column :trade_licenses, :fine_fee, :integer
  end
end
