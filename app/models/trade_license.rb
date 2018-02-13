class TradeLicense < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :trade_organization
  #after_initialize :init
  has_one :collection_money, as: :collectable, dependent: :destroy
  accepts_nested_attributes_for :collection_money, :allow_destroy => true

  validates :fiscal_year, presence: true
  validates_uniqueness_of :fiscal_year, scope: :trade_organization
  validates :fiscal_year, length: {is: 4}

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
    self.collection_money.fine if self.collection_money.fine.present?
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
    "<p> #{self.trade_organization.enterprize_name_in_bng}<br>প্রোপাইটর: #{self.trade_organization.owners_name_bng} </p>".html_safe
  end

  def remove
    collection_money.remove if collection_money.present?
  end

  private

  def license_fiscal_year
    return Time.now.year.to_s unless self.fiscal_year.present?
    self.fiscal_year.to_s
  end

  def init
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 7 #if fiscal year less than june
    self.fiscal_year = year.to_s
  end

end
