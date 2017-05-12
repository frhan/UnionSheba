class CreateCitizenBasics < ActiveRecord::Migration
  def change
    create_table :citizen_basics do |t|
      t.string :nid
      t.string :birthid
      t.date :dob
      t.string :passport_no
      t.string :gender
      t.references :maritial_status, index: true, foreign_key: true
      t.references :citizenship_state, index: true, foreign_key: true
      t.references :religion, index: true, foreign_key: true
      t.references :basicable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
