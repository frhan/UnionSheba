class AddStatusToWorkInfo < ActiveRecord::Migration
  def change
    add_column :work_infos, :status, :string,default: :active
    add_column :freedom_fighters, :status, :string,default: :active
    add_column :relationships, :status, :string,default: :active
    add_column :warish_relations, :status, :string,default: :active
  end
end
