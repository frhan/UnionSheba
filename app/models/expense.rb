class Expense < ActiveRecord::Base
  include VoucherHelper
  belongs_to :expense_category
  belongs_to :union
  belongs_to :voucher

  validates :expense_money, presence: true
  after_create :save_serial_no, :save_voucher_no

  def exp_category
    return self.other_category if self.expense_category.others?
    self.expense_category.name
  end

  def babod
    return "<p>#{self.expense_category.name}<br/>#{self.other_category}<p>".html_safe if self.expense_category.others?
    self.expense_category.name
  end

  def bank_info
    return String.new if self.bank_check_no.blank?
    return "<p> #{self.bank_check_no}<br>#{self.check_date.strftime('%d-%m-%Y')} </p>".html_safe
  end

  def v_type
    self.expense_category.category_code
  end

  def main_type
    :expenses
  end

  private

  def save_serial_no
    srl_no = Expense.where(union_id: self.union.id).count(:serial_no)
    srl_no = srl_no + 1
    self.update_attributes(:serial_no => srl_no)
  end

end
