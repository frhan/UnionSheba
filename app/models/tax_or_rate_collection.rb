class TaxOrRateCollection < ActiveRecord::Base
  has_one :collection_money,as: :collectable,dependent: :destroy

  accepts_nested_attributes_for :collection_money,:allow_destroy => true

end
