class AddStatusToContactAddress < ActiveRecord::Migration
  def change
    add_column :contact_addresses, :status, :string,default: :active,default: :active
  end
end
