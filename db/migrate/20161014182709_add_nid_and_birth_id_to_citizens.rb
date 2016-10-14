class AddNidAndBirthIdToCitizens < ActiveRecord::Migration
  def change
    add_column :citizens, :nid, :string
    add_column :citizens, :birthid, :string
  end
end
