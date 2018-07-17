class Expense < ActiveRecord::Base
  belongs_to :expense_category
  belongs_to :union

  validates :expense_money, presence: true
  after_create :save_serial_no

  def exp_category
    if self.expense_category.others?
      return self.other_category
    end
    self.expense_category.name
  end

  def bank_info
    return String.new if self.bank_check_no.blank?
    return "<p> #{self.bank_check_no}<br>#{self.check_date.strftime('%d-%m-%Y')} </p>".html_safe
  end

  private

  def save_serial_no
    srl_no = Expense.where(union_id: self.union.id).count(:serial_no)
    srl_no = srl_no + 1
    self.update_attributes(:serial_no => srl_no)
  end

end
