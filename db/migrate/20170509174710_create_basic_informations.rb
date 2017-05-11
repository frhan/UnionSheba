class CreateBasicInformations < ActiveRecord::Migration
  def change
    create_table :basic_infos do |t|
      t.string :name
      t.string :fathers_name
      t.string :mothers_name
      t.string :maritial_status
      t.string :nid
      t.string :birth_id
      t.string :date_of_birth
      t.string :lang
      t.references :infoable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
