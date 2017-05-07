class TaxCategory < ActiveRecord::Base
  has_many :tax_or_rate_collections

  def others?
    self.name == 'অন্যান্য'
  end
end
