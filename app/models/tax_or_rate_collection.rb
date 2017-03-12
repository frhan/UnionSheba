class TaxOrRateCollection < ActiveRecord::Base
  include ApplicationHelper, UnionHelper, CollectionBanglaHelper
  has_one :collection_money, as: :collectable, dependent: :destroy

  accepts_nested_attributes_for :collection_money, :allow_destroy => true
  belongs_to :union

  validates :owners_name, :village_name, :apprisal_no, :owners_name_in_english, presence: true

  def money_senders_name
    self.owners_name
  end

  def init(trade_org)
    if trade_org.present?
      self.village_name = mouja trade_org.business_place
      self.owners_name = trade_org.owners_name_bng
      self.owners_name_in_english = trade_org.owners_name_eng
    end
  end

  def mouja(village_name)
    village_name << ' (' << current_fiscal_year_bangla << ' অর্থবছরের পেশা, ব্যবসা, জীবিকার কর বাবদ' << ')'
  end

end
