class CreateForWhoms < ActiveRecord::Migration
  def change
    create_table :for_whoms do |t|
      t.string :who
      t.string :who_in_bangla
      t.string :who_in_english
      t.string :lang

      t.timestamps null: false
    end
  end
end
