class AddNidBirthidToTradeOrganizations < ActiveRecord::Migration
  def change
    add_column :trade_organizations, :nid, :string
    add_column :trade_organizations, :birthid, :string
  end
end
