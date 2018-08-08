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
end
