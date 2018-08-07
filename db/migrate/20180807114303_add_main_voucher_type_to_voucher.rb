class AddMainVoucherTypeToVoucher < ActiveRecord::Migration
  def change
    add_column :vouchers, :main_voucher_type, :string
    add_column :vouchers, :status, :string,default: :active
  end
end
