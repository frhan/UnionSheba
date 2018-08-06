class AddFathersDeathDateToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :fathers_death_date, :date
  end
end
