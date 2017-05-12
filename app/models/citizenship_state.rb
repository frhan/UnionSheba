class CitizenshipState < ActiveRecord::Base
  has_many :citizen_basics
  def present_citizen?
    self.name_en == 'Present'
  end

  def permanent_citizen?
    self.name_en == 'Permanent'
  end

end
