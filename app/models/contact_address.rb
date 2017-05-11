class ContactAddress < ActiveRecord::Base
  belongs_to :contactable,polymorphic: true
end
