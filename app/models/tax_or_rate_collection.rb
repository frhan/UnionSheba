class TaxOrRateCollection < ActiveRecord::Base
  has_one :collection_money , as: :collectable
end
