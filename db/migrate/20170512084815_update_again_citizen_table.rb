class UpdateAgainCitizenTable < ActiveRecord::Migration
  def change
    remove_columns :citizens,:birthid , :nid, :email,:mobile_no,:gender
  end
end
