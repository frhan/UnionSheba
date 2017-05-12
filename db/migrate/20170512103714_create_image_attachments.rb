class CreateImageAttachments < ActiveRecord::Migration
  def change
    create_table :image_attachments do |t|
      t.string :photo
      t.references :attachable, polymorphic: true, index: true

      t.timestamps null: false
    end

    add_column :basic_infos, :spouse_name,:string
  end
end
