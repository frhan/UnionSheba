class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  def present_address?
    return self.address_type == 'present'
  end

  def permanent_address?
    return self.address_type == 'permanent'
  end
end
