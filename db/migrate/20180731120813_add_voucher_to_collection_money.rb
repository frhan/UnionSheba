class AddVoucherToCollectionMoney < ActiveRecord::Migration
  def change
    add_reference :collection_moneys, :voucher, index: true, foreign_key: true
  end
end
