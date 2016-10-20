class TradeLicense < ActiveRecord::Base
  belongs_to :trade_organization
  after_create :save_trade_license_no

  private

  def save_trade_license_no
    trade_license_no = trade_organization.union.union_code << '-'<< license_fiscal_year << '-' << license_count.to_s
    self.update_attributes(:licsense_no => trade_license_no)
  end

  def license_count
    #TradeLicense.where(fiscal_year: self.fiscal_year).count + 1
    TradeLicense.count + 1
  end

  def license_fiscal_year
    if self.fiscal_year.nil?
       return Time.now.year.to_s
    end
    self.fiscal_year.to_s
  end

end
