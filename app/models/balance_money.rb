class BalanceMoney < ActiveRecord::Base
  belongs_to :union

  scope :by_tax_year, -> (year) { where(tax_year: year) }
end
