class AddWhomOthersAndBanglaIncomeToWorkInfo < ActiveRecord::Migration
  def change
    add_column :work_infos, :for_whom_others, :string
    add_column :work_infos, :income_in_bangla, :string
  end
end
