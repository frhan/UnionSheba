class AddUnionsAndSerialNoToCollectionMoneys < ActiveRecord::Migration
  def change
    add_reference :collection_moneys, :union, index: true, foreign_key: true
  end
end
