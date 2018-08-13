class AddCategoryCodeToTaxCategory < ActiveRecord::Migration
  def change
    add_column :tax_categories, :category_code, :string
  end
end
