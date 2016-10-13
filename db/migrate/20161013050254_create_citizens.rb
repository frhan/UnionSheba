class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.string :name_in_eng
      t.string :name_in_bng
      t.string :fathers_name
      t.string :mothers_name
      t.string :village
      t.string :post
      t.integer :post
      t.references :union, index: true, foreign_key: true
      t.string :spouse_name

      t.timestamps null: false
    end
  end
end
