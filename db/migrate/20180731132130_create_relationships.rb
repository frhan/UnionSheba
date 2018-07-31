class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :to_whom
      t.string :relation_type
      t.string :person_title

      t.timestamps null: false
    end
  end
end
