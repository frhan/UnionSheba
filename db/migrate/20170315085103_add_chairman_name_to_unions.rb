class AddChairmanNameToUnions < ActiveRecord::Migration
  def change
    add_column :unions, :chairman_name, :string
  end
end
