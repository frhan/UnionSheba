class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.integer :voucher_no
      t.string :check_no
      t.date :check_date
      t.references :union, index: true, foreign_key: true
      t.string :voucher_type

      t.timestamps null: false
    end
  end
end
