class TaxOrRateCollection < ActiveRecord::Base
  has_one :collection_money , as: :collectable
  accepts_nested_attributes_for :collection_money,allow_destroy: true


end
