class TradeOrganization < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :union
  has_many :trade_licenses, dependent: :destroy
  accepts_nested_attributes_for :trade_licenses,:allow_destroy => true
  validates_uniqueness_of :license_no,scope: :union
  after_create :save_license_no

  validates :enterprize_name_in_eng,:enterprize_name_in_bng,
            :owners_name_eng,:owners_name_bng,
            :fathers_name,:mothers_name,
            :village_name,:post_name,
            :upazilla_name,:zilla_name,:word_no,
            :business_place,:business_category,
            presence: true

  def address
      self.village_name << ',' << self.upazilla_name << ',' << self.zilla_name
  end

  def latest_trade_license
    trade_license ||= self.trade_licenses.order('fiscal_year desc').first
  end

  def fee
    return String.new unless latest_trade_license.present?
    taka = bangla_number latest_trade_license.license_fee.to_s
    taka << ' টাকা মাত্র ।'
  end

  def license_fee
      fee_number latest_trade_license.license_fee
  end

  def license_deadline
    return String.new unless latest_trade_license.present?
    latest_trade_license.fiscal_year
  end

  def deadline
    return String.new unless latest_trade_license.present?
    latest_trade_license.deadline
  end

  def deadline_top
    return String.new unless latest_trade_license.present?
    latest_trade_license.deadline_top
  end

  def fiscal_year
    return String.new unless latest_trade_license.present?
    latest_trade_license.fiscal_year_show
  end

  def total_fee
      fee_number latest_trade_license.total_fee
  end

  def fine
      fee_number latest_trade_license.fine_fee
  end

  def remain
      fee_number latest_trade_license.remaining_fee
  end

  def word_no_bn
    return String.new unless word_no.present?
    bangla_number word_no.to_s
  end

  private

  def save_license_no
    license_no = self.union.union_code << '-'<< current_year_month_day.to_s << '-' << max_count.to_s
    self.update_attributes(:license_no => license_no)
  end

  def max_count
    count = TradeOrganization.where(union_id: self.union.id).count
    count
  end

  def fee_number(number)
    taka = '0'
    taka = number.to_s if number.present?
    bangla_number taka << '.00'
  end

end
