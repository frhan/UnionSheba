class AddWordNoToTradeOrganization < ActiveRecord::Migration
  def change
    add_column :trade_organizations, :word_no, :integer
  end
end
