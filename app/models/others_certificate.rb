class OthersCertificate < ActiveRecord::Base
  include ApplicationHelper, UnionHelper

  belongs_to :union

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :basic_infos, as: :infoable, dependent: :destroy
  has_one :contact_address, as: :contactable, dependent: :destroy
  has_one :citizen_basic, as: :basicable, dependent: :destroy
  has_one :image_attachment, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :basic_infos, allow_destroy: true
  accepts_nested_attributes_for :contact_address, allow_destroy: true
  accepts_nested_attributes_for :citizen_basic, allow_destroy: true
  accepts_nested_attributes_for :image_attachment, allow_destroy: true

end
