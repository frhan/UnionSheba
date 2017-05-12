class CreateMaritialStatuses < ActiveRecord::Migration
  def change
    create_table :maritial_statuses do |t|
      t.string :name_en
      t.string :name_bn

      t.timestamps null: false
    end
  end
end
