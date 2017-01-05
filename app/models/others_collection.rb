class OthersCollection <  ActiveRecord::Base
  include ApplicationHelper,UnionHelper,CollectionBanglaHelper
  has_one :collection_money,as: :collectable,dependent: :destroy

  accepts_nested_attributes_for :collection_money,:allow_destroy => true
  belongs_to :union
end
