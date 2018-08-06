class AddShortNameToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :nick_name, :string
  end
end
