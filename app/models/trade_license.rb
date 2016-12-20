class TradeLicense < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :trade_organization
  after_create :save_trade_license_no

  validates :fiscal_year,:license_fee , presence: true
  validates_uniqueness_of :fiscal_year,scope: :trade_organization

  def deadline
    if !self.fiscal_year.nil?
      "৩০ জুন " << bangla_number((self.fiscal_year + 1).to_s) << " পর্যন্ত বৈধ"
    end
  end

  def fiscal_year_show
    if !self.fiscal_year.nil?
      bangla_number(self.fiscal_year.to_s) << ' - '<< bangla_number((self.fiscal_year + 1).to_s)
    end
  end

  private

  def save_trade_license_no
    trade_license_no = trade_organization.union.union_code << '-'<< license_fiscal_year << '-' << license_count.to_s
    self.update_attributes(:licsense_no => trade_license_no)
  end

  def license_count
    #TradeLicense.where(fiscal_year: self.fiscal_year).count + 1
    #TODO: count -> join with trade org. where trade-organization union id ->
    # self.trade_org.uinon_id and licsense fiscal year
    TradeLicense.count + 1
  end

  def license_fiscal_year
    if self.fiscal_year.nil?
       return Time.now.year.to_s
    end
    self.fiscal_year.to_s
  end

end
