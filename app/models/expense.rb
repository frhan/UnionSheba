class Expense < ActiveRecord::Base
  belongs_to :expense_category
  belongs_to :union

  validates :expense_money, presence: true

  def exp_category
    if self.expense_category.others?
      return self.other_category
    end
    self.expense_category.name
  end

end
