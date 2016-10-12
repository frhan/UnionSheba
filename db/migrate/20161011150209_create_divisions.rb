class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name_in_eng
      t.string :name_in_bng
      t.string :desc

      t.timestamps null: false
    end
  end
end
