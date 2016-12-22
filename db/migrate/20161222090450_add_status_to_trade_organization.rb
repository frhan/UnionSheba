class AddStatusToTradeOrganization < ActiveRecord::Migration
  def change
    add_column :trade_organizations, :status, :string, default: :active
  end
end
