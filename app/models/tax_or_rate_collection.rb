class TaxOrRateCollection < ActiveRecord::Base
  include ApplicationHelper,UnionHelper,CollectionBanglaHelper
  has_one :collection_money,as: :collectable,dependent: :destroy

  accepts_nested_attributes_for :collection_money,:allow_destroy => true
  belongs_to :union

  validates :owners_name,:village_name,:apprisal_no,:owners_name_in_english,presence: true

  def money_senders_name
    self.owners_name
  end

end
