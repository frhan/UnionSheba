class TaxCategory < ActiveRecord::Base
  has_many :tax_or_rate_collections
end
