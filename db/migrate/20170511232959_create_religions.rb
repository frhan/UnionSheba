class CreateReligions < ActiveRecord::Migration
  def change
    create_table :religions do |t|
      t.string :name_en
      t.string :name_bn

      t.timestamps null: false
    end
  end
end
