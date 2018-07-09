class ExpenseCategory < ActiveRecord::Base
  has_many :expenses

  def others?
    self.name == 'অন্যান্য'
  end
end
