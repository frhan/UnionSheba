class AddStatusToCollectionMoneys < ActiveRecord::Migration
  def change
    add_column :collection_moneys, :status, :string,default: :active
  end
end
