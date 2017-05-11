class CreateContactAddresses < ActiveRecord::Migration
  def change
    create_table :contact_addresses do |t|
      t.string :mobile_no
      t.string :email
      t.references :contactable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
