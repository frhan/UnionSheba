class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :village
      t.string :road
      t.integer :word_no
      t.string :district
      t.string :upazila
      t.string :post_office
      t.string :type
      t.string :lang
      t.references :addressable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
