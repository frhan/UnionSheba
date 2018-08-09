class AddStatusToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :status, :string, default: :active
  end
end
