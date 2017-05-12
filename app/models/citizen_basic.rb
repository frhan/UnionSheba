class CitizenBasic < ActiveRecord::Base


  belongs_to :maritial_status
  belongs_to :citizenship_state
  belongs_to :religion
end
