class ChangeColumnTypeToAddressTypeFromAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :type,:address_type
    add_column :basic_infos, :state,:string
  end
end
