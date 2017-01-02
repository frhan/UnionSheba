class AddSerialNoToMoneyCollection < ActiveRecord::Migration
  def change
    add_column :collection_moneys,:serial_no,:integer
  end
end
