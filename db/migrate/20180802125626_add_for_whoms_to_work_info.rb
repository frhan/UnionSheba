class AddForWhomsToWorkInfo < ActiveRecord::Migration
  def change
    add_reference :work_infos, :for_whom, index: true, foreign_key: true
  end
end
