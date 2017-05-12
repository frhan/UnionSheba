class CreateCitizenshipStates < ActiveRecord::Migration
  def change
    create_table :citizenship_states do |t|
      t.string :name_en
      t.string :name_bn
    end
  end
end
