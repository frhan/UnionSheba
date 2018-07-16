class AddDeadPersonNameToWarishes < ActiveRecord::Migration
  def change
    add_column :warishes, :dead_person_name, :string
  end
end
