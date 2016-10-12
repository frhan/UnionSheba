class Union < ActiveRecord::Base
  belongs_to :upazila

  def to_s
    name_in_bng
  end
end
