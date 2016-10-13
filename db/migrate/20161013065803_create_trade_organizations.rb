class CreateTradeOrganizations < ActiveRecord::Migration
  def change
    create_table :trade_organizations do |t|
      t.string :enterprize_name_in_eng
      t.string :enterprize_name_in_bng
      t.string :owners_name_eng
      t.string :owners_name_bng
      t.string :fathers_name
      t.string :mothers_name
      t.string :spouse_name
      t.string :village_name
      t.string :post_name
      t.string :upazilla_name
      t.string :zilla_name
      t.string :business_place
      t.string :business_category
      t.references :union, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
