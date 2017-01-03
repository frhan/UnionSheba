class CollectionMoney < ActiveRecord::Base
  belongs_to :collectable,polymorphic: true
  validates :fee,presence: true
  belongs_to :union

  after_create :save_serial_no

  def total
    total = 0.0
    total = total + self.fee if self.fee.present?
    total = total + self.remain if self.remain.present?
    total = total + self.fine if self.fine.present?
    total = total + self.vat if self.vat.present?
    total
  end

 private

  def save_serial_no
    serial_no = CollectionMoney.where(union_id: self.union.id).count
    self.update_attributes(:serial_no => serial_no)
  end

end
