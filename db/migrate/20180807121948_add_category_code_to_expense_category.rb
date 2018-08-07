class AddCategoryCodeToExpenseCategory < ActiveRecord::Migration
  def change
    add_column :expense_categories, :category_code, :string
  end
end
