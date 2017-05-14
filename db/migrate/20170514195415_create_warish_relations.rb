class CreateWarishRelations < ActiveRecord::Migration
  def change
    create_table :warish_relations do |t|
      t.string :name
      t.string :relation
      t.integer :age
      t.string :lang
      t.references :warish , index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
