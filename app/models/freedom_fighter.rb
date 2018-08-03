class FreedomFighter < ActiveRecord::Base
  belongs_to :others_certificate
  #belongs_to :union, through: :others_certificate
end
