class CreateBalanceMoneys < ActiveRecord::Migration
  def change
    create_table :balance_moneys do |t|
      t.references :union, index: true, foreign_key: true
      t.integer :tax_year
      t.integer :value
      t.string :note

      t.timestamps null: false
    end
  end
end
