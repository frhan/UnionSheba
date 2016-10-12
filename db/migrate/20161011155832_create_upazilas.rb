class CreateUpazilas < ActiveRecord::Migration
  def change
    create_table :upazilas do |t|
      t.string :name_in_eng
      t.string :name_in_bng
      t.references :district,index: true, foreign_key: true
      t.string :desc

      t.timestamps null: false
    end
  end
end
