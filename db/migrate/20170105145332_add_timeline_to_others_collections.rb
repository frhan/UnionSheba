class AddTimelineToOthersCollections < ActiveRecord::Migration
  def change
    add_column :others_collections, :time_line, :string
  end
end
