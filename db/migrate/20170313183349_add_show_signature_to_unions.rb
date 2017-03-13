class AddShowSignatureToUnions < ActiveRecord::Migration
  def change
    add_column :unions, :show_signature, :boolean, default: false
  end
end
