class UpdateCitizenTable < ActiveRecord::Migration
  def change
    add_column :citizens, :tracking_id,:string
    remove_columns :citizens, :name_in_eng,:name_in_bng,:fathers_name,:mothers_name,
                   :village,:post,:word_no,:spouse_name
    remove_columns :basic_infos,:maritial_status, :nid,:birth_id,:date_of_birth
  end
end
