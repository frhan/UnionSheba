class Union < ActiveRecord::Base
  belongs_to :upazila
  has_many :citizens

  def to_s
    name_in_bng
  end
end
