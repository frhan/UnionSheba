class CreateWorkInfos < ActiveRecord::Migration
  def change
    create_table :work_infos do |t|
      t.string :workplace_name
      t.integer :annual_income
      t.string :work_title
      t.string :lang

      t.timestamps null: false
    end
  end
end
