class CreateOthersCollections < ActiveRecord::Migration
  def change
    create_table :others_collections do |t|
      t.string :senders_name
      t.string :senders_address

      t.timestamps null: false
    end
  end
end
