class CreateUnions < ActiveRecord::Migration
  def change
    create_table :unions do |t|
      t.string :name_in_eng
      t.string :name_in_bng
      t.references :upazila, index: true, foreign_key: true
      t.integer :union_no
      t.string :post

      t.timestamps null: false
    end
  end
end
