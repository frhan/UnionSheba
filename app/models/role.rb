class Role < ActiveRecord::Base
 has_many :users
  def to_s
   role_name
  end
end