ActiveAdmin.register Expense do

 permit_params :expense_money, :serial_no,:status,:note,:other_category,:fiscal_year

end
