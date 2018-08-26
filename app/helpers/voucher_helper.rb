module VoucherHelper

  def save_voucher_no
    voucher = Voucher.where(union_id: self.union.id,
                            voucher_type: v_type,
                            main_voucher_type: main_type,
                            created_at: Date.today.beginning_of_day..Date.today.end_of_day,
                            status: :active)

    voucher = voucher.first if voucher.present?

    if voucher.blank?
      #create at from july 1

      voucher_count = Voucher.where(union_id: self.union.id,
                                    created_at: first_day_fiscal_year.beginning_of_day..Date.today.end_of_day,
                                    main_voucher_type: main_type,
                                    status: :active).count

      voucher = Voucher.create(voucher_no: voucher_count + 1,
                               main_voucher_type: main_type,
                               voucher_type: v_type,
                               union: self.union)
    end

    self.update_attributes(voucher: voucher)
  end

  def first_day_fiscal_year
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 7 #if fiscal year less than june
    DateTime.parse("#{year}-07-01")
  end

  def last_day_fiscal_year
    now = Time.now
    year = now.year
    year = year + 1 if now.month > 7 #if fiscal year less than june
    DateTime.parse("#{year}-06-30")
  end

end