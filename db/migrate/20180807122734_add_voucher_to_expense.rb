class AddVoucherToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :voucher, index: true, foreign_key: true
  end
end
