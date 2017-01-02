class CreateCollectionMoneys < ActiveRecord::Migration
  def change
    create_table :collection_moneys do |t|
      t.decimal :fee
      t.decimal :remain
      t.decimal :fine
      t.decimal :vat
      t.references :collectable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
