class AddGenderToCitizen < ActiveRecord::Migration
  def change
    add_column :citizens, :gender, :string
  end
end
