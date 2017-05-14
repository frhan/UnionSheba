class CreateWarishes < ActiveRecord::Migration
  def change
    create_table :warishes do |t|
      t.string :warish_no
      t.string :tracking_id
      t.string :status
      t.references :union, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
