class AddSendersNameToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :senders_name, :string
  end
end
