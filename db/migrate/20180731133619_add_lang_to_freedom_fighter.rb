class AddLangToFreedomFighter < ActiveRecord::Migration
  def change
    add_column :freedom_fighters, :lang, :string
  end
end
