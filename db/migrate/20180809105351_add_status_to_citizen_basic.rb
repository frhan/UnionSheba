class AddStatusToCitizenBasic < ActiveRecord::Migration
  def change
    add_column :citizen_basics, :status, :string
  end
end
