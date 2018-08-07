class Voucher < ActiveRecord::Base
  belongs_to :union
  has_many :collection_moneys

  def total
    self.collection_moneys.sum(:fee) + self.collection_moneys.sum(:fine) +
        self.collection_moneys.sum(:remain) + self.collection_moneys.sum(:vat)
  end
end
