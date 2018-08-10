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

  def remove

  end


  def rearrance_voucher
    vouchers = Voucher.where(union_id: self.union.id, main_voucher_type: self.main_voucher_type,
                  :created_at =>self.created_at.beginning_of_day..self.created_at.end_of_day, status: :active)
  end

end
