class Upazila < ActiveRecord::Base
  belongs_to :district

  def to_s
    name_in_bng
  end
end
