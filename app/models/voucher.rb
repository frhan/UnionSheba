class Voucher < ActiveRecord::Base
  belongs_to :union
  belongs_to :voucherable,polymorphic: true
end
