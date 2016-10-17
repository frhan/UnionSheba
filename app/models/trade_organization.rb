class TradeOrganization < ActiveRecord::Base
  belongs_to :union
  has_many :trade_licenses
  accepts_nested_attributes_for :trade_licenses,:allow_destroy => true

  def address
      self.village_name << ',' << self.upazilla_name << ',' << self.zilla_name
  end

  def latest_trade_license
    trade_license ||= self.trade_licenses.order('fiscal_year desc').first
  end

  def fee
    if !latest_trade_license.nil?
      latest_trade_license.license_fee
    end

  end

  def license_deadline
    if !latest_trade_license.nil?
      latest_trade_license.fiscal_year
    end
  end

end
