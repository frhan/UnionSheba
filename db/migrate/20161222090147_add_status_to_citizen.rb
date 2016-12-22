class AddStatusToCitizen < ActiveRecord::Migration
  def change
    add_column :citizens, :status, :string, default: :active
  end
end
