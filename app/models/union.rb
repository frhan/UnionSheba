class Union < ActiveRecord::Base
  belongs_to :upazila
  has_many :citizens
  has_many :trade_organizations
  has_many :collection_moneys
  has_many :tax_or_rate_collections

  def to_s
    name_in_bng
  end
end
