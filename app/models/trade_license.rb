class TradeLicense < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :trade_organization
  after_initialize :init
  has_one :collection_money,as: :collectable,dependent: :destroy
  accepts_nested_attributes_for :collection_money,:allow_destroy => true

  validates :fiscal_year , presence: true
  validates_uniqueness_of :fiscal_year,scope: :trade_organization
  validates :fiscal_year, length: { is: 4 }

  def deadline_top
    return String.new unless self.fiscal_year.present?
    "৩০ জুন " << bangla_number((self.fiscal_year + 1).to_s) << " পর্যন্ত বৈধ"
  end

  def deadline
    return String.new unless self.fiscal_year.present?
    bangla_number((self.fiscal_year + 1).to_s)
  end

  def fiscal_year_show
    return String.new unless self.fiscal_year.present?
    bangla_number(self.fiscal_year.to_s) << ' - '<< bangla_number((self.fiscal_year + 1).to_s)
  end

  def fiscal_year_show_eng
    return String.new unless self.fiscal_year.present?
    self.fiscal_year.to_s << ' - '<< (self.fiscal_year + 1).to_s
  end

  def total_fee
    return 0 if self.collection_money.nil?
    self.collection_money.total
  end

  def license_fee
    return 0 if self.collection_money.nil?
    self.collection_money.fee if self.collection_money.fee.present?
  end

  def fine_fee
    return 0 if self.collection_money.nil?
    self.collection_money.fine  if self.collection_money.fine.present?
  end

  def remaining_fee
    return 0 if self.collection_money.nil?
    self.collection_money.remain if self.collection_money.remain.present?
  end

  def vat
    return 0 if self.collection_money.nil?
    self.collection_money.vat if self.collection_money.vat.present?
  end

  def money_collection_serial_no
    return 0 if self.collection_money.nil?
    self.collection_money.serial_no if self.collection_money.serial_no.present?
  end

  def money_senders_name
    self.trade_organization.owners_name_bng
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
    return Time.now.year.to_s unless self.fiscal_year.present?
    self.fiscal_year.to_s
  end

  def init
    self.fiscal_year ||= current_year
  end

end
