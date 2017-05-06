class CreateTaxCategories < ActiveRecord::Migration
  def change
    create_table :tax_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
