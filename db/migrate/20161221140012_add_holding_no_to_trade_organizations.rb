class AddHoldingNoToTradeOrganizations < ActiveRecord::Migration
  def change
    add_column :trade_organizations, :holding_no, :string
  end
end
