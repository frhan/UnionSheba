class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :name
      t.string :state
      t.string :workspace_name
      t.integer :annual_income
      t.references :occupable, polymorphic: true, index: true


      t.timestamps null: false
    end
  end
end
