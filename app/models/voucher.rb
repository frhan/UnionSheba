class Voucher < ActiveRecord::Base
  belongs_to :union
  has_many :collection_moneys
  has_many :expenses

  def total
    self.collection_moneys.sum(:fee) + self.collection_moneys.sum(:fine) +
        self.collection_moneys.sum(:remain) + self.collection_moneys.sum(:vat)
  end

  def total_expense
    self.expenses.sum(:expense_money)
  end

  def collection?
    self.main_voucher_type == 'collection'
  end

  def expense?
    self.main_voucher_type == 'expense'
  end

  def remove

    if collection? && self.collection_moneys.count > 1
      rearrange_voucher
      return
    end

    if expense? && self.expenses.count > 1
      rearrange_voucher
      return
    end

    self.update_attributes status: :deleted
  end


  def rearrange_voucher
    vouchers = Voucher.where(union_id: self.union.id, main_voucher_type: self.main_voucher_type,
                  :created_at =>self.created_at.beginning_of_day..self.created_at.end_of_day, status: :active)
    if vouchers.present?
      vouchers.vouchers do |v,index|
        v.update_attributes voucher_no: index
      end
    end

  end

end
