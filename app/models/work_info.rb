class WorkInfo < ActiveRecord::Base
  belongs_to :others_certificate
  belongs_to :for_whom
end
