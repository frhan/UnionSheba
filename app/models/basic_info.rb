class BasicInfo < ActiveRecord::Base
  belongs_to :infoable, polymorphic: true
end
