class AddLogoWatermarkLogoCodeToUnion < ActiveRecord::Migration
  def change
    add_column :unions, :logo, :string
    add_column :unions, :watermark_logo, :string
    add_column :unions, :union_code, :string
  end
end
