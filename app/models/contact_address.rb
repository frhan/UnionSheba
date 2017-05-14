class ContactAddress < ActiveRecord::Base
  belongs_to :contactable,polymorphic: true

  validates :mobile_no, presence: true

end
