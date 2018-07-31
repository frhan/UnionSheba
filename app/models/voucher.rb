class Voucher < ActiveRecord::Base
  belongs_to :union
  has_many :collection_moneys
end
