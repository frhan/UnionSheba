class TaxOrRateCollection < ActiveRecord::Base
  include ApplicationHelper, UnionHelper, CollectionBanglaHelper
  has_one :collection_money, as: :collectable, dependent: :destroy

  accepts_nested_attributes_for :collection_money, :allow_destroy => true
  belongs_to :union
  belongs_to :tax_category

  validates :owners_name, :village_name, :apprisal_no, :owners_name_in_english, presence: true

  def money_senders_name
    self.owners_name
  end

  def init_val(trade_org_id)
    self.tax_year = current_fiscal_year_bangla

    if trade_org_id.present?
      init(TradeOrganization.find(trade_org_id))
    end
  end

  def init(trade_org)
    self.village_name = trade_org.business_place
    self.owners_name = trade_org.owners_name_bng
    self.owners_name_in_english = trade_org.owners_name_eng
    self.apprisal_no = chromic_no trade_org.license_no
    self.tax_category = TaxCategory.first if TaxCategory.first.present?
  end

  def mouja(village_name)
    village_name << ' (' << current_fiscal_year_bangla << ' অর্থবছরের পেশা, ব্যবসা, জীবিকার কর বাবদ' << ')'
  end

  def chromic_no(license_no)
    license_no.split('-').last if license_no.present?
  end

  def category
    return self.tax_category.name
  end

  def babod
    return self.other_reason if self.tax_category.present? && self.tax_category.others?
    return self.tax_category.name if self.tax_category.present?
    return String.new
  end

  def babod_pdf
    babod_val = String.new
    babod_val << bangla_number(self.tax_year) << ' অর্থবছরের ' if self.tax_year.present?
    babod_val << babod
  end

end
