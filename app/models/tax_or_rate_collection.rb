class TaxOrRateCollection < ActiveRecord::Base
  include ApplicationHelper,UnionHelper
  has_one :collection_money,as: :collectable,dependent: :destroy

  accepts_nested_attributes_for :collection_money,:allow_destroy => true
  belongs_to :union

  def serial_no_bangla
    bangla_number self.collection_money.serial_no.to_s
  end

  def fine_bangla
    bangla_number self.collection_money.fine.to_s
  end

  def fee_bangla
    bangla_number self.collection_money.fee.to_s
  end

  def total_bangla
    bangla_number self.collection_money.total.to_s
  end

end
