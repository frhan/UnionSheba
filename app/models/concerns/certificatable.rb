module Certificatable
  extend ActiveSupport::Concern
  included do
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

  def set_status(status)
    self.status = status
  end

  def active?
    self.status == 'active'
  end

  def pending?
    self.status == 'pending'
  end

  def basic_information
    @basic_info ||= self.basic_infos.info(current_lang).first if self.basic_infos.info(current_lang).present?
    @basic_info
  end

  def present_address
    @present_address ||= self.addresses.present(current_lang).first if self.addresses.present(current_lang).first.present?
    @present_address
  end

  def permanent_address
    @permanent_address ||= self.addresses.permanent(current_lang).first if self.addresses.permanent(current_lang).first.present?
    @permanent_address
  end




end