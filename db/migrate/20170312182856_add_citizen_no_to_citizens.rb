class AddCitizenNoToCitizens < ActiveRecord::Migration
  def change
    add_column :citizens, :citizen_no, :string
  end
end
