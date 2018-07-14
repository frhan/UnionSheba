class CreateOthersCertificates < ActiveRecord::Migration
  def change
    create_table :others_certificates do |t|
      t.string :lang
      t.string :status
      t.string :certifcate_no
      t.string :tracking_no

      t.timestamps null: false
    end
  end
end
