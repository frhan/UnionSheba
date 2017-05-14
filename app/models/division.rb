class Division < ActiveRecord::Base
  has_many :districts

  def to_s
    name_in_bng
  end
end
