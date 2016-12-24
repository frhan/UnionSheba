class AddMobileNoEmailToCitizens < ActiveRecord::Migration
  def change
    add_column :citizens, :email, :string
    add_column :citizens, :mobile_no, :string
    add_column :citizens, :requested_at, :timestamp
    add_column :citizens, :saved_at, :timestamp
  end
end
