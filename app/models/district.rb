class District < ActiveRecord::Base
  belongs_to :division
  has_many :upazilas

  def to_s
    name_in_bng
  end
end
