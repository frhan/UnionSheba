class CollectionMoney < ActiveRecord::Base
  belongs_to :collectable,polymorphic: true
  validates :fee,presence: true
  belongs_to :union

  def total
    total = 0.0
    total = total + self.fee if self.fee.present?
    total = total + self.remain if self.remain.present?
    total = total + self.fine if self.fine.present?
    total = total + self.vat if self.vat.present?
    total
  end

  def save_union(union)
    self.union = union
  end

end
