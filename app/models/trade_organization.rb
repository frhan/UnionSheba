class TradeOrganization < ActiveRecord::Base
  belongs_to :union
  has_many :trade_licenses
  accepts_nested_attributes_for :trade_licenses,:allow_destroy => true

  def address
      self.village_name << ',' << self.upazilla_name << ',' << self.zilla_name
  end

  def fee
    '২০০'
  end

  def license_deadline
    '২০১৫'
  end

end
