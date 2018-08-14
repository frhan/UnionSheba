class Voucher < ActiveRecord::Base
  belongs_to :union
  has_many :collection_moneys
  has_many :expenses

  def total
    self.collection_moneys.sum(:fee)
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
    self.update_attributes status: :deleted

    if collection? && self.collection_moneys.count > 1
      rearrange_voucher
    end

    if expense? && self.expenses.count > 1
      rearrange_voucher
    end

  end


  def rearrange_voucher
    vouchers = Voucher.where(union_id: self.union.id, main_voucher_type: self.main_voucher_type,
                             :created_at => self.created_at.beginning_of_day..self.created_at.end_of_day,
                             status: :active).order("voucher_id asc")

    yesterday = self.created_at.yesterday
    count = Voucher.where(union_id: self.union.id, :created_at => yesterday.beginning_of_day..yesterday.end_of_day,
                          main_voucher_type: self.main_voucher_type, status: :active).count
    if vouchers.present?
      vouchers.each do |v|
        v.update_attributes voucher_no: count + 1
      end
    end

  end

end
