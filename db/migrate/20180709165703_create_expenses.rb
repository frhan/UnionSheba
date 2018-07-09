class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :expense_money
      t.string :note
      t.string :other_category
      t.integer :fiscal_year
      t.references :union, index: true, foreign_key: true
      t.references :expense_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
