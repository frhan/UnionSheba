class TradeOrganization < ActiveRecord::Base
  belongs_to :union
  has_many :trade_licenses
end
