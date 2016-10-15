class TradeOrganization < ActiveRecord::Base
  belongs_to :union
  has_many :trade_licenses
  accepts_nested_attributes_for :trade_licenses


end
