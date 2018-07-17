class AddBankCheckNoAndCheckDateToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :bank_check_no, :string
    add_column :expenses, :check_date, :date
  end
end
