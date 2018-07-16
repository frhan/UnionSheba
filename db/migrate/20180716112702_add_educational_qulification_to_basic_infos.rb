class AddEducationalQulificationToBasicInfos < ActiveRecord::Migration
  def change
    add_column :basic_infos, :educational_qualification, :string
  end
end
