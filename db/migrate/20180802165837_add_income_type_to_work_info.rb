class AddIncomeTypeToWorkInfo < ActiveRecord::Migration
  def change
    add_column :work_infos, :income_type, :string
  end
end
