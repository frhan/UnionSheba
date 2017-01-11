class OthersCollection <  ActiveRecord::Base
  include ApplicationHelper,UnionHelper,CollectionBanglaHelper
  has_one :collection_money,as: :collectable,dependent: :destroy

  accepts_nested_attributes_for :collection_money,:allow_destroy => true
  belongs_to :union

  validates :senders_name,:senders_address,:time_line,:owners_name_in_english,presence: true

  def money_senders_name
    self.senders_name
  end

end
