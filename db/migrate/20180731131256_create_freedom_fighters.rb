class CreateFreedomFighters < ActiveRecord::Migration
  def change
    create_table :freedom_fighters do |t|
      t.string :red_book_no
      t.string :indian_no
      t.string :gazette_no

      t.timestamps null: false
    end
  end
end
