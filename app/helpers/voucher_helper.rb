module VoucherHelper

  def save_voucher_no
    voucher = Voucher.where(union_id: self.union.id, voucher_type: v_type, main_voucher_type: main_type,
                            :created_at => Date.today.beginning_of_day..Date.today.end_of_day, status: :active)

    voucher = voucher.first if voucher.present?

    if voucher.blank?
      voucher_count = Voucher.where(union_id: self.union.id, main_voucher_type: main_type, status: :active).count

      voucher = Voucher.create(voucher_no: voucher_count + 1, main_voucher_type: main_type,
                               voucher_type: v_type, union: self.union)
    end

    self.update_attributes(voucher: voucher)
  end


end