class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name_in_eng
      t.string :name_in_bng
      t.string :desc
      t.references :division, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
