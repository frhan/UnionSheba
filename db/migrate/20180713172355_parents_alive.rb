class ParentsAlive < ActiveRecord::Migration
  def change
    add_column :basic_infos, :father_alive, :boolean, default: true
    add_column :basic_infos, :mother_alive, :boolean, default: true
    add_column :expenses, :serial_no, :integer
  end
end
